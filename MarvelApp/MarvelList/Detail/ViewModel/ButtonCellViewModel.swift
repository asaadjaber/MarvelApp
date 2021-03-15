//
//  ButtonCellViewModel.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import Foundation

struct DetailButtonCellViewModel {
    var buttonTitle: String
    var isAdded: Bool
    
    init(isAdded: Bool) {
        self.isAdded = isAdded
        
        let addString = "💪" + " " + "Recruit to Squad"
        let removeString = "🔥" + "Fire from Squad"
        self.buttonTitle = isAdded ?  removeString : addString
    }
}
