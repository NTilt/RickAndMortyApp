//
//  EpisodesService.swift
//  RickAndMortyApp
//
//  Created by Никита Ясеник on 17.08.2023.
//

import Foundation


class EpisodesService {
    
    func getEpisode(url: String, completion: @escaping(Result<Episode?, CharacterError>) -> Void) {
        
        guard let url = URL(string: url) else {
            return completion(.failure(.BadURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.BadData))
            }
            let episodeResponse = try? JSONDecoder().decode(Episode.self, from: data)
            if let episodeResponse = episodeResponse {
                completion(.success(episodeResponse))
            }
            else {
                completion(.failure(.DecodingError))
            }
        }
        .resume()
        
    }
}
