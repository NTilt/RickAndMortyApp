//
//  RickAndMortyAppApp.swift
//  RickAndMortyApp
//
//  Created by Никита Ясеник on 16.08.2023.
//

import SwiftUI

@main
struct RickAndMortyAppApp: App {
    
    @ObservedObject private var appModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    appModel.fetchCharacters()
                }
                .preferredColorScheme(.dark)
                .environmentObject(appModel)
        }
    }
}
