//
//  CharactersView.swift
//  RickAndMortyApp
//
//  Created by Никита Ясеник on 16.08.2023.
//

import SwiftUI
import UIKit

struct CharactersView: UIViewControllerRepresentable {

    typealias UIViewControllerType = CharactersViewController
    
    @EnvironmentObject var appModel: AppViewModel
    
    func makeUIViewController(context: Context) -> CharactersViewController {
        return CharactersViewController(appModel: appModel)
    }
    
    func updateUIViewController(_ uiViewController: CharactersViewController, context: Context) {
    }

}


final class CharactersViewController: UIViewController {
    
    private lazy var charactersView = CharactersCollectionView(appModel: appModel)
    
    var appModel: AppViewModel
    
    init(appModel: AppViewModel) {
        self.appModel = appModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.addSubview(charactersView)
        view.backgroundColor = UIColor(red: 0.016, green: 0.047, blue: 0.118, alpha: 1)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        charactersView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: view.bounds.height
        )
    }
}
