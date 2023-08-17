//
//  CharacterItem.swift
//  RickAndMortyApp
//
//  Created by Никита Ясеник on 16.08.2023.
//

import SwiftUI

struct CharacterItem: View {
    
    var image: String
    var name: String
    
    var body: some View {
        VStack {
            CacheAsyncImage(url: URL(string: image)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 140, height: 140)
                         .clipShape(RoundedRectangle(cornerRadius: 10))
                case .failure(_):
                    EmptyView()
                case .empty:
                    ProgressView()
                        .frame(width: 140, height: 140)
                @unknown default:
                    fatalError()
                }
            }
            Text(name)
                .foregroundColor(.white)
                .font(.system(size: 17, weight: .semibold))
                .padding(.top)
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.149, green: 0.165, blue: 0.22))
        }
    }
}

struct CharacterItem_Previews: PreviewProvider {
    static var previews: some View {
        CharacterItem(image: "testImage", name: "Rick Sanchez")
            .preferredColorScheme(.dark)
    }
}
