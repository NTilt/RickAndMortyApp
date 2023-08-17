//
//  EpisodeView.swift
//  RickAndMortyApp
//
//  Created by Никита Ясеник on 17.08.2023.
//

import SwiftUI
import UIKit

struct EpisodeView: View {
    
    var episode: Episode
    
    var seasonNumber: Int {
        parseSeason(inputString: episode.episode).0
    }
    
    var episodeNumber: Int {
        parseSeason(inputString: episode.episode).1
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(episode.name)
                .foregroundColor(.white)
                .font(.system(size: 17, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text("Episode: \(episodeNumber), Season: \(seasonNumber)")
                    .foregroundColor(Color(red: 0.278, green: 0.776, blue: 0.043))
                    .font(.system(size: 13, weight: .medium))
                Spacer()
                Text(episode.airDate)
                    .foregroundColor(Color(red: 0.576, green: 0.596, blue: 0.612))
                    .font(.system(size: 12, weight: .medium))
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.149, green: 0.165, blue: 0.22))
        }
        .padding(.horizontal)
    }
    
    private func parseSeason(inputString: String) -> (Int, Int) {
        let components = inputString.components(separatedBy: "E")
        if components.count == 2, let seasonNumber = Int(components[0].replacingOccurrences(of: "S", with: "")), let episodeNumber = Int(components[1]) {
            return (seasonNumber, episodeNumber)
        } else {
            return (0, 0)
        }
    }
}
