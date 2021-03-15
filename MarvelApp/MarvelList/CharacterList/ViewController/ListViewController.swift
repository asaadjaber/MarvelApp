//
//  ListViewController.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/14/21.
//

import UIKit

class ComposableGridViewController: UIViewController, UICollectionViewDelegate {
    static let headerElementKind = "header-kind"

    var collectionView: UICollectionView! = nil
        
    var listDataSource: ListDataSource! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, MarvelCharacter>! = nil
            
    var cellRegistration: UICollectionView.CellRegistration<ListCell, MarvelCharacter>!

    var orthogonalCellRegistration: UICollectionView.CellRegistration<OrthogonalCell, MarvelCharacter>!

    var headerRegistration: UICollectionView.SupplementaryRegistration<TitleSupplementaryView>!
    
    var layout: UICollectionViewLayout!
    
    var imageAPI: ImageAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = UIColor(displayP3Red: 34/255, green: 37/255, blue: 43/255, alpha: 1.0)
        appearance.shadowColor = UIColor(displayP3Red: 61/255, green: 64/255, blue: 69/255, alpha: 1.0)
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.isTranslucent = false
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 68.27, height: 32))
        imageView.image = UIImage(named: "marvel_nav")!
        
        navigationItem.titleView = imageView
        
        layout = createFullLayout()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self

        view.addSubview(collectionView)
        
        configureCellRegistration()
        configureDataSource()
        
        listDataSource.setDataSourceModel()
        layout = createFullLayout()

    }
            
    private func configureCellRegistration() {
        cellRegistration = UICollectionView.CellRegistration<ListCell, MarvelCharacter> { (cell, indexPath, character) in
            let listCellViewModel = ListCellViewModel(name: character.name, thumbnail: character.thumbnail)
            self.imageAPI.requestImage(withURL: listCellViewModel.imageURL, completion: { (image) in
                let image = image
                cell.thumbImageView.image = image!
            })
            cell.nameLabel.text = listCellViewModel.name
        }
        
        orthogonalCellRegistration = UICollectionView.CellRegistration<OrthogonalCell, MarvelCharacter> { (cell, indexPath, character) in
            let orthogonalCellViewModel = OrthogonalCellViewModel(name: character.name, thumbnail: character.thumbnail)
            self.imageAPI.requestImage(withURL: orthogonalCellViewModel.imageURL, completion: { (image) in
                let image = image
                cell.thumbImageView.image = image!
            })
            cell.nameLabel.text = orthogonalCellViewModel.name
        }
        
        headerRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: ComposableGridViewController.headerElementKind) { (supplementaryView, string, indexPath) in
            let headerViewModel = HeaderViewModel()
            supplementaryView.titleLabel.text = headerViewModel.sectionTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let listItems = listDataSource.items(for: Section.orthogonal)
        
        var orthogonalSnapshot = NSDiffableDataSourceSectionSnapshot<MarvelCharacter>()
        orthogonalSnapshot.append(listItems)
        dataSource.apply(orthogonalSnapshot, to: .orthogonal)
    }
    
    func configureDataSource() {
        listDataSource = ListDataSource(collectionView: collectionView, cellRegistration, orthogonalCellRegistration, headerRegistration) { [weak self] (controller: ListDataSource) in
            guard let self = self else { return }
            self.applySnapshot()
        }
        dataSource = listDataSource.dataSource
    }
    
    private func applySnapshot() {
        let sections: [Section] = [.orthogonal, .main]

        for section in sections {
            let sectionsItems = listDataSource.items(for: section)
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<MarvelCharacter>()
            sectionSnapshot.append(sectionsItems)
            dataSource.apply(sectionSnapshot, to: section)
        }
    }
            
    func createFullLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else {
                return nil
            }
            switch sectionKind {
            case .main:
                return self.createListSectionLayout()
            case .orthogonal:
                if self.listDataSource.items(for: sectionKind).isEmpty {
                    return self.emptySection()
                }
                return self.createOrthogonalSectionLayout()
            }
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    func createListSectionLayout() ->  NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(76))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        return section
    }
    
    func createOrthogonalSectionLayout() ->  NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(64), heightDimension: .absolute(104))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(57))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ComposableGridViewController.headerElementKind, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }

    func emptySection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(1), heightDimension: .absolute(1))
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(1), heightDimension: .absolute(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
    
        return section
    }
    
    var currCharacter: MarvelCharacter!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMarvelCharacter = self.dataSource.itemIdentifier(for: indexPath) else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
                
        let detailViewController = DetailViewController(with: selectedMarvelCharacter, imageAPI: self.imageAPI)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}




