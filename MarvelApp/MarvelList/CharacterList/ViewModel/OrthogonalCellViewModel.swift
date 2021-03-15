//
//  OrthogonalCellViewModel.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import Foundation

struct OrthogonalCellViewModel {
    let name: String
    let imageURL: URL
    
    init(name: String, thumbnail: CharacterImage) {
        self.name = name
        self.imageURL = ImageURLBuilder.getURL(with: (thumbnail, .square, .fantastic))
    }
}
