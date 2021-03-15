//
//  Character.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/13/21.
//

import Foundation
import Combine

struct MarvelCharacter: Codable {
    let name: String
    let description: String
    let thumbnail: CharacterImage
    
    var isAdded: CurrentValueSubject<Bool, Never> = .init(false)
    
    let identifier: UUID = UUID()

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

struct CharacterImage: Codable {
    let path: String
    let imageExtension: String
    
    private enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
