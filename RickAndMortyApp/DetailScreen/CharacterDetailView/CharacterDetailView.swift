//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Никита Ясеник on 16.08.2023.
//

import SwiftUI

struct CharacterDetailView: View {
    
    var character: Character
    @EnvironmentObject var appModel: AppViewModel
    @Environment(\.presentationMode) private var presentationMode
    var episodes: [Episode] {
        appModel.getEpisodesForCharacter(character)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("backArrow")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .padding()
                
                VStack(spacing: 24) {
                    CacheAsyncImage(url: URL(string: character.image)) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(maxWidth: 148, maxHeight: 148)
                                 .clipShape(RoundedRectangle(cornerRadius: 10))
                        case .failure(_):
                            EmptyView()
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: 148, maxHeight: 148)
                        @unknown default:
                            fatalError()
                        }
                    }
                    VStack(spacing: 8) {
                        Text(character.name)
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                        Text(character.status.rawValue)
                            .foregroundColor(.green)
                            .font(.system(size: 16, weight: .medium))
                    }
                }
                InfoSection()
                OriginSection()
                EpisodesSection()
            }
        }
        .background {
            Color(red: 0.016, green: 0.047, blue: 0.118, opacity: 1)
                .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    func EpisodesSection() -> some View {
        VStack(spacing: 16) {
            Text("Episodes")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal)
            ForEach(episodes, id: \.id) { episode in
                EpisodeView(episode: episode)
            }
        }
    }
    
    @ViewBuilder
    func OriginSection() -> some View {
        VStack {
            Text("Origin")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal)
            HStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0.098, green: 0.11, blue: 0.165))
                    .frame(width: 64, height: 64)
                    .overlay {
                        Image("planetIcon")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                    }
                VStack(alignment: .leading, spacing: 8) {
                    Text(character.origin.name)
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .semibold))
                    Text("Planet")
                        .foregroundColor(.green)
                        .font(.system(size: 13, weight: .medium))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 0.149, green: 0.165, blue: 0.22))
            }
            .padding(.horizontal)
            
        }
        
    }
    
    @ViewBuilder
    func InfoSection() -> some View {
        VStack {
            Text("Info")
                 .frame(maxWidth: .infinity, alignment: .leading)
                 .font(.system(size: 17, weight: .semibold))
                 .foregroundColor(.white)
                 .padding(.horizontal)
            VStack(spacing: 16) {
                HStack {
                    Text("Species:")
                        .foregroundColor(Color(red: 0.769, green: 0.788, blue: 0.808))
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                    Text(character.species)
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                }
                HStack {
                    Text("Type:")
                        .foregroundColor(Color(red: 0.769, green: 0.788, blue: 0.808))
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                    Text(character.type)
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                }
                HStack {
                    Text("Gender:")
                        .foregroundColor(Color(red: 0.769, green: 0.788, blue: 0.808))
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                    Text(character.gender.rawValue)
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 0.149, green: 0.165, blue: 0.22))
            }
            .padding(.horizontal)
        }
        
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
