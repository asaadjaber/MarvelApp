//
//  DetailHeaderViewModel.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import Foundation

struct DetailHeaderViewModel {
    let headerTitle: String
    let imageURL: URL

    init(name: String, thumbnail: CharacterImage) {
        self.headerTitle = name
        self.imageURL = ImageURLBuilder.getURL(with: (thumbnail, .detail, nil))
    }
}
