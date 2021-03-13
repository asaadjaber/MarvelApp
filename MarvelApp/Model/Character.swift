//
//  Character.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/13/21.
//

import Foundation

struct MarvelCharacter: Decodable {
    let name: String
    let description: String
    let thumbnail: CharacterImage
}

struct CharacterImage: Decodable {
    let path: String
    let imageExtension: String
    
    private enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
