//
//  Footer.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import UIKit

class DetailFooterSupplementaryView: UICollectionReusableView {
    let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.numberOfLines = 0
                
        addSubview(descriptionLabel)

        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(descriptionLabelConstraints)
    }
}
