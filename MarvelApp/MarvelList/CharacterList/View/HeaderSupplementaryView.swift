//
//  HeaderSupplementaryView.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import UIKit

class TitleSupplementaryView: UICollectionReusableView {
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        titleLabel.textColor = UIColor.white
        
        addSubview(titleLabel)
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
}
