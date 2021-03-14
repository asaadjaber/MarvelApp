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
    
    var identifier = UUID()
    
    private enum CodingKeys: CodingKey {
        case name, description, thumbnail
    }
}

extension MarvelCharacter: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

struct CharacterImage: Decodable {
    let path: String
    let imageExtension: String
    
    private enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
