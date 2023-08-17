//
//  CharactersCollectionView.swift
//  RickAndMortyApp
//
//  Created by Никита Ясеник on 16.08.2023.
//

import UIKit
import SwiftUI
import Combine


final class CharactersCollectionView: UIView {

    var appModel: AppViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    init(appModel: AppViewModel) {
        self.appModel = appModel
        super.init(frame: .zero)
        addSubview(charactersCollectionView)
        setup()
        
        appModel.$characters
            .sink { [weak self] _ in
                self?.charactersCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 156, height: 202)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 40, left: 20, bottom: 0, right: 20)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 0.016, green: 0.047, blue: 0.118, alpha: 1)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    private func setup() {
        charactersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            charactersCollectionView.topAnchor.constraint(equalTo: topAnchor),
            charactersCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            charactersCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            charactersCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
}

extension CharactersCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        if indexPath.row == appModel.characters.count - 1 {
            appModel.loadMoreCharacters()
        }
        cell.contentConfiguration = UIHostingConfiguration(content: {
            NavigationLink {
                CharacterDetailView(character: appModel.characters[indexPath.row])
                    .environmentObject(appModel)
            } label: {
                CharacterItem(image: appModel.characters[indexPath.row].image, name: appModel.characters[indexPath.row].name)
            }
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        appModel.characters.count
    }
}
