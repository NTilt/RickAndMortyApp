//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Никита Ясеник on 16.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoading: Bool = false
    @EnvironmentObject var appModel: AppViewModel
    
    var body: some View {
        if appModel.isLoading {
            LaunchScreenView()
        }
        else {
            NavigationView {
                CharactersView()
                    .environmentObject(appModel)
                    .ignoresSafeArea()
                    .navigationTitle("Characters")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
