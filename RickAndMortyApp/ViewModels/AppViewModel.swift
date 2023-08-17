//
//  AppViewModel.swift
//  RickAndMortyApp
//
//  Created by Никита Ясеник on 17.08.2023.
//

import Foundation
import SwiftUI
import UIKit

class AppViewModel: ObservableObject {
    
    @Published var characters: [Character] = [Character]()
    @Published var episodes: [Episode] = [Episode]()
    
    @Published var isLoading: Bool = true
    
    var urlForLoadCharacters: String = "https://rickandmortyapi.com/api/character"
    
    func fetchCharacters() {
        CharactersService().getCharacters(url: urlForLoadCharacters) { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result {
                case .success(let data):
                    self.characters.append(contentsOf: data?.results ?? [])
                    self.urlForLoadCharacters = data?.info.next ?? ""
                    self.isLoading = false
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
    
    func fetchEpisodes(episodesURLs: [String]) {
        episodesURLs.forEach { url in
            EpisodesService().getEpisode(url: url) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let episode):
                        if let episode = episode {
                            self.addEpisode(episode: episode)
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    func fetchEpisode(episodesURL: String) {
        EpisodesService().getEpisode(url: episodesURL) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let episode):
                    if let episode = episode {
                        self.addEpisode(episode: episode)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func addEpisode(episode: Episode) {
        if !episodes.contains(where: { oldEpisode in
            oldEpisode.id == episode.id
        }) {
            episodes.append(episode)
        }
    }
    
    func getEpisodesForCharacter(_ character: Character) -> [Episode] {
        var episodesForCharacter: [Episode] = []
        character.episode.forEach { episodeURL in
            if let episode = episodes.first(where: { oldEpisode in
                oldEpisode.url == episodeURL
            }) {
                episodesForCharacter.append(episode)
            }
            else {
                fetchEpisode(episodesURL: episodeURL)
            }
        }
        return episodesForCharacter
    }
    
    func loadMoreCharacters() {
        fetchCharacters()
    }
    
}
