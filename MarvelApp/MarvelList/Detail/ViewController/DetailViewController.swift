//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate, DetailViewControllerCellDelegate, DetailSupplementaryViewCellDelegate {
    enum SupplementaryViewKind: String {
        case headerElementKind
        case footerElementKind
    }
    
    static let headerElementKind = "headerElementKind"
    static let footerElementKind = "footerElementKind"
    
    var character: MarvelCharacter!

    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    var collectionView: UICollectionView! = nil

    var cellRegistration: UICollectionView.CellRegistration<DetailButtonCell, Int>!

    var headerRegistration: UICollectionView.SupplementaryRegistration<DetailSupplementaryView>!

    var footerRegistration: UICollectionView.SupplementaryRegistration<DetailFooterSupplementaryView>!
    
    var imageAPI: ImageAPI!

    var removeAlertController: UIAlertController!
    
    var currentCell: DetailButtonCell!

    init(with character: MarvelCharacter, imageAPI: ImageAPI) {
        self.character = character
        self.imageAPI = imageAPI
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var layout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(59)) //buttonHeight + ShadowHeight
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
                
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(UIScreen.main.bounds.width + 81))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: DetailViewController.headerElementKind, alignment: .top)
     
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,elementKind: DetailViewController.footerElementKind, alignment: .bottom)
        
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]

        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAlertController()
        
        navigationItem.hidesBackButton = true
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(displayP3Red: 34/255, green: 37/255, blue: 43/255, alpha: 1.0)
        collectionView.contentInsetAdjustmentBehavior = .never

        view.addSubview(collectionView)
        
        registerCellThenStandbyForConfigure()

        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<1))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func registerCellThenStandbyForConfigure() {
        cellRegistration = UICollectionView.CellRegistration<DetailButtonCell, Int> { (cell, indexPath, model) in
            let cellViewModel = DetailButtonCellViewModel(isAdded: self.character.isAdded.value)
            cell.button.setTitle(cellViewModel.buttonTitle, for: .normal)
            cell.isAdded = cellViewModel.isAdded
        }
        
        headerRegistration = UICollectionView.SupplementaryRegistration<DetailSupplementaryView>(elementKind: DetailViewController.headerElementKind) { (supplementaryView, string, indexPath) in
            let headerViewModel = DetailHeaderViewModel(name: self.character.name, thumbnail: self.character.thumbnail)
            self.imageAPI.requestImage(withURL: headerViewModel.imageURL, completion: { (image) in
                supplementaryView.detailImageView.image = image
            })
            supplementaryView.headerTitle.text = headerViewModel.headerTitle
        }
        
        footerRegistration = UICollectionView.SupplementaryRegistration<DetailFooterSupplementaryView>(elementKind: DetailViewController.footerElementKind) { (supplementaryView, string, indexPath) in
            let footerViewModel = DetailFooterViewModel(description: self.character.description)
            supplementaryView.descriptionLabel.text = footerViewModel.description
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: Int) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: item)
            cell.delegate = self
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            guard let viewKind = SupplementaryViewKind(rawValue: kind) else {
                fatalError("Unknown supplementary view kind")
            }
            
            switch viewKind {
            case .headerElementKind:
                let supplementaryView = self.collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: index)
                supplementaryView.delegate = self
                return supplementaryView
            case .footerElementKind:
                let supplementaryView = self.collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: index)
                return supplementaryView
            }
        }
    }
            
    func returnFromDetailScreen(_ cell: DetailSupplementaryView) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
    func initAlertController() {
        let alertMessage = "Are you sure you want to remove \(character.name) from your Squad?"
        
        removeAlertController = UIAlertController(title: "Slow Down", message: alertMessage, preferredStyle: .alert)

        let remove = UIAlertAction(title: "Remove", style: .destructive) { (action) in
            self.dismiss(animated: true) {
                self.removeAlertController.dismiss(animated: true) {
                    self.switchCharacterState(self.currentCell)
                }
            }
        }
        
        let keep = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.dismiss(animated: true)
        }
        
        removeAlertController.addAction(remove)
        removeAlertController.addAction(keep)
    }
    
    // MARK: - Character State Publisher
    
    func addRemoveCharacter(_ cell: DetailButtonCell) {
    
        //  Note: Send the value of the new cell button state to the DataSource to update the selected Character's data.
        
        if cell.isAdded == true {
            present(removeAlertController, animated: true) {
                self.currentCell = cell
            }
        } else {
            self.switchCharacterState(cell)
        }
    }
    
    func switchCharacterState(_ cell: DetailButtonCell) {
        cell.isAdded = !cell.isAdded
        character.isAdded.send(cell.isAdded)

        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<1))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
