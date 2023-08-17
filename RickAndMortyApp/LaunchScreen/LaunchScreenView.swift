//
//  LaunchScreenView.swift
//  RickAndMortyApp
//
//  Created by Никита Ясеник on 16.08.2023.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Color(red: 0.016, green: 0.047, blue: 0.118)
                .ignoresSafeArea()
            Image("LaunchScreenImage3")
                .background {
                    VStack(spacing: 36) {
                        Image("LaunchScreenImage2")
                        Image("LaunchScreenImage1")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.top, 70)
                }
            
            
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
