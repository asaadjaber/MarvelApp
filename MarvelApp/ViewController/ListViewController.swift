//
//  ListViewController.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/14/21.
//

import UIKit

class ComposableGridViewController: UIViewController {
    var collectionView: UICollectionView! = nil
    
    var listDataSource: ListDataSource!
    var dataSource: UICollectionViewDiffableDataSource<Section, MarvelCharacter>! = nil
            
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, MarvelCharacter>!
        
    let layout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(76))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(76))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
                
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        
        view.addSubview(collectionView)
        
        registerCellThenStandbyForConfigure()
                
        listDataSource = ListDataSource(collectionView: collectionView, cellRegistration: cellRegistration)
        dataSource = listDataSource.dataSource
        
        listDataSource.setDataSourceModel()
    }
    
    private func registerCellThenStandbyForConfigure() {
        cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, MarvelCharacter> { (cell, indexPath, model) in
            cell.backgroundColor = UIColor.magenta
        }
    }
}
