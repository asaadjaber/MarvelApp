//
//  DataSource.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/14/21.
//

import UIKit

class ListDataSource {
    var marvelCharacters = [MarvelCharacter]()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, MarvelCharacter>!
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, MarvelCharacter>
    
    var collectionView: UICollectionView!
    
    var charactersAPI: MarvelCharactersAPI!
    
    init(collectionView: UICollectionView, cellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, MarvelCharacter>, charactersAPI: MarvelCharactersAPI = MarvelCharactersAPI(requestLoader: APIRequestLoader(apiRequest: CharacterRequestAPI()))) {
        self.collectionView = collectionView
        self.cellRegistration = cellRegistration
        self.charactersAPI = charactersAPI
        self.setDataSourceAndDequeueConfiguredCell()
    }
    
    private func setDataSourceAndDequeueConfiguredCell() {
        dataSource = UICollectionViewDiffableDataSource<Section, MarvelCharacter>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, model: MarvelCharacter) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: model)
            
            return cell
        }
    }
    
    func setDataSourceModel() {
        charactersAPI.getMarvelCharacters { (result) in
            switch result {
            case let .success(res):
                self.marvelCharacters = res
                self.applySnapshot()
            case let .failure(error):
                print("Get Marvel Characters Error: \(error)")
            }
        }
    }
    
    //  TO DO: Move the logic for updating the collection view to the ViewController. 
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MarvelCharacter>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.marvelCharacters)

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
