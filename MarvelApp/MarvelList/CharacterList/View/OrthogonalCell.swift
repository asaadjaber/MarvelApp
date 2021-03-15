//
//  OrthogonalCell.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import UIKit

class OrthogonalCell: UICollectionViewCell {
    let thumbImageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    func configure() {
        let constThumbFrameWidth = CGFloat(64.0)
        
        thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbImageView.layer.cornerRadius = constThumbFrameWidth / 2
        thumbImageView.contentMode = .scaleAspectFit
        thumbImageView.clipsToBounds = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .semibold)
        nameLabel.textColor = UIColor.white
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        nameLabel.lineBreakMode = .byTruncatingTail
        
        contentView.addSubview(thumbImageView)
        contentView.addSubview(nameLabel)

        let thumbImageConstraints = [
            thumbImageView.topAnchor.constraint(equalTo: topAnchor, constant: 1.0),
            thumbImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            thumbImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            thumbImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
        ]
        
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: thumbImageView.bottomAnchor, constant: 4.0),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
        ]
        
        NSLayoutConstraint.activate(thumbImageConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
    }
}
