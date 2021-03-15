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
    
    var cellRegistration: UICollectionView.CellRegistration<ListCell, MarvelCharacter>!
    
    var orthogonalCellRegistration: UICollectionView.CellRegistration<OrthogonalCell, MarvelCharacter>!
    
    var headerRegistration: UICollectionView.SupplementaryRegistration<TitleSupplementaryView>!
    
    var collectionView: UICollectionView!
        
    static let documentPath = "MarvelApp.DataSource.MarvelCharacters"
    
    typealias UpdateHandler = (ListDataSource) -> Void
    private let updateHandler: UpdateHandler

    var json: Data? {
        return try? JSONEncoder().encode(marvelCharacters)
    }
    
    init(collectionView: UICollectionView, _ cellRegistration: UICollectionView.CellRegistration<ListCell, MarvelCharacter>, _ orthogonalCellRegistration: UICollectionView.CellRegistration<OrthogonalCell, MarvelCharacter>, _ headerRegistration: UICollectionView.SupplementaryRegistration<TitleSupplementaryView>, updateHandler: @escaping UpdateHandler) {
        self.updateHandler = updateHandler
        self.collectionView = collectionView
        self.cellRegistration = cellRegistration
        self.orthogonalCellRegistration = orthogonalCellRegistration
        self.headerRegistration = headerRegistration
        self.setDataSourceAndDequeueConfiguredCell()
    }
    
    func setDataSourceModel() {
        if let characters = checkDataOnDisk() {
            self.marvelCharacters = characters
            self.updateHandler(self)
            return
        }
        
        let charactersAPI = MarvelCharactersAPI(requestLoader: APIRequestLoader(apiRequest: CharacterRequestAPI()))
        charactersAPI.getMarvelCharacters { (result) in
            switch result {
            case let .success(res):
                self.marvelCharacters = res
                self.updateHandler(self)
            case let .failure(error):
                print("Characters handler Error: \(error)")
            }
        }
    }

    func items(for section: Section) -> [MarvelCharacter] {
        switch section {
        case .main:
            return self.marvelCharacters
        case .orthogonal:
            var filteredList = [MarvelCharacter]()
            
            (self.marvelCharacters.filter { ($0.isAdded.value == true) }).forEach { (character) in
                filteredList.append(MarvelCharacter(name: character.name, description: character.description, thumbnail: character.thumbnail, isAdded: character.isAdded))
            }
            return filteredList
        }
    }

    private func setDataSourceAndDequeueConfiguredCell() {
        dataSource = UICollectionViewDiffableDataSource<Section, MarvelCharacter>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, model: MarvelCharacter) -> UICollectionViewCell? in
                        
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section")
            }
            
            var cell: UICollectionViewCell!
            switch section {
            case .main:
                cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: model)
            case .orthogonal:
                cell = collectionView.dequeueConfiguredReusableCell(using: self.orthogonalCellRegistration, for: indexPath, item: model)
            }
    
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            let supplementaryView = self.collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: index)
            
            return supplementaryView
        }
    }
    
    private func checkDataOnDisk() -> [MarvelCharacter]? {
        let charactersJSON = UserDefaults.standard.data(forKey: ListDataSource.documentPath)
        if let json = charactersJSON {
            do {
                let charArr = try JSONDecoder().decode([MarvelCharacter].self, from: json)
                return charArr
            } catch let error {
                print("JSON decoder error: ", error)
            }
        }
        return nil
    }
}
