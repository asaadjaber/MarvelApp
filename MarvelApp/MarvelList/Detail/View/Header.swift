//
//  Header.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import UIKit

protocol DetailSupplementaryViewCellDelegate: class {
    func returnFromDetailScreen(_ cell: DetailSupplementaryView)
}

class DetailSupplementaryView: UICollectionReusableView {
    let backButton = UIButtonTappable()
    let detailImageView = UIImageView()
    let headerTitle = UILabel()
    weak var delegate: DetailSupplementaryViewCellDelegate?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureViews() {
        
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.backgroundColor = UIColor(displayP3Red: 34/255, green: 37/255, blue: 43/255, alpha: 1.0)
        detailImageView.contentMode = .scaleAspectFill
        detailImageView.clipsToBounds = true
        
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.font = UIFont.systemFont(ofSize: 34.0, weight: .bold)
        headerTitle.textColor = UIColor.white
        headerTitle.numberOfLines = 1
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: "back_arrow")!, for: .normal)
        backButton.addTarget(self, action: #selector(self.addRemoveCharacter), for: .touchUpInside)

        addSubview(detailImageView)
        addSubview(headerTitle)
        addSubview(backButton)

        let detailImageViewConstraints = [
            detailImageView.topAnchor.constraint(equalTo: topAnchor),
            detailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailImageView.widthAnchor.constraint(equalTo: widthAnchor),
            detailImageView.heightAnchor.constraint(equalTo: widthAnchor)
        ]
        
        let headerTitleConstraints = [
            headerTitle.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 24),
            headerTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]
        
        let backButtonConstraints = [
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            backButton.widthAnchor.constraint(equalToConstant: 22),
            backButton.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        NSLayoutConstraint.activate(detailImageViewConstraints)
        NSLayoutConstraint.activate(headerTitleConstraints)
        NSLayoutConstraint.activate(backButtonConstraints)
    }
    
    @objc func addRemoveCharacter(_ sender: UIButton) {
        delegate?.returnFromDetailScreen(self)
    }
}
