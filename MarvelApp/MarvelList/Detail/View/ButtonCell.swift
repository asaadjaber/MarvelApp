//
//  ButtonCell.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import UIKit

protocol DetailViewControllerCellDelegate: class {
    func addRemoveCharacter(_ cell: DetailButtonCell)
}

class DetailButtonCell: UICollectionViewCell {
    var button = UIButton()

    /**
        - Important:
            - The button cell publishes "state" to the DataSource via its delegate, DetailViewController. (See DetailViewController section, marked: "Character State Publisher").
            - The .isAdded property is set once, by the instantiating ViewModel instance, and is updated every time the cell changes state via user input.
     */
    
    let buttonFill = UIColor(displayP3Red: 243/255, green: 12/255, blue: 11/255, alpha: 1.0)
    
    var isAdded: Bool = false {
        didSet {
            print("isAdded Cell,", isAdded)
           // button.setTitle(viewModel.buttonTitle, for: .normal)
            
            if isAdded { //in list -> show empty button
                button.backgroundColor = UIColor.clear

                button.layer.borderWidth = 3
                button.layer.borderColor = buttonFill.cgColor
                
                button.layer.shadowOpacity = 0
                
            } else {
                button.backgroundColor = buttonFill
                
                button.layer.borderWidth = 0
                button.layer.borderColor = buttonFill.cgColor
                
                button.layer.shadowOpacity = 0.5
                button.layer.shadowOffset = CGSize(width: 0, height: 5)
                button.layer.shadowRadius = 3.0
                button.layer.shadowColor = buttonFill.cgColor
            }
        }
    }
        
    weak var delegate: DetailViewControllerCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
                
        let edgeInset = CGFloat(16)
        button = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - (2 * edgeInset), height: 43))
        
        button.layer.cornerRadius = 8
        button.layer.cornerCurve = .continuous
        button.titleLabel!.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        button.addTarget(self, action: #selector(self.addRemoveCharacter), for: .touchUpInside)

        button.center = CGPoint(x: center.x, y: button.center.y)
                
        contentView.addSubview(button)
    }
    
    //Action Flow:
    
    @objc func addRemoveCharacter(_ sender: UIButton) {
            
//        if !isAdded {
//            self.isAdded = !isAdded
//        }
        
        //1. Tell delegate button Was Pressed
        delegate?.addRemoveCharacter(self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}
