//
//  ListCell.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import UIKit

class ListCell: UICollectionViewListCell {
    let container = UIView()
    let thumbImageView = UIImageView()
    let nameLabel = UILabel()
    let arrowView = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    func setUpViews() {
        contentView.backgroundColor = UIColor(displayP3Red: 34/255, green: 37/255, blue: 43/255, alpha: 1.0)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowView.translatesAutoresizingMaskIntoConstraints = false

        container.backgroundColor = UIColor(displayP3Red: 54/255, green: 59/255, blue: 69/255, alpha: 1.0)
        container.layer.cornerCurve = .continuous
        container.layer.cornerRadius = 8.0
        
        let constThumbFrameWidth = CGFloat(44)
        
        thumbImageView.backgroundColor = UIColor.lightGray
        thumbImageView.contentMode = .scaleAspectFill
        thumbImageView.layer.cornerRadius = constThumbFrameWidth / 2
        thumbImageView.clipsToBounds = true
        
        nameLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        nameLabel.textColor = UIColor.white

        arrowView.setImage(UIImage(named: "cell_arrow")!, for: .normal)
                
        container.addSubview(thumbImageView)
        container.addSubview(nameLabel)
        container.addSubview(arrowView)

        contentView.addSubview(container)
        
        let listImageConstraints = [
            thumbImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            thumbImageView.widthAnchor.constraint(equalToConstant: constThumbFrameWidth),
            thumbImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbImageView.heightAnchor.constraint(equalToConstant: constThumbFrameWidth)
        ]
                
        let listNameConstraints = [
            nameLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: arrowView.leadingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let arrowConstraints = [
            arrowView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            arrowView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowView.widthAnchor.constraint(equalToConstant: 10),
            arrowView.heightAnchor.constraint(equalToConstant: 16)
        ]
    
        let containerConstraints = [
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(listImageConstraints)
        NSLayoutConstraint.activate(listNameConstraints)
        NSLayoutConstraint.activate(arrowConstraints)
        NSLayoutConstraint.activate(containerConstraints)
    }
}
