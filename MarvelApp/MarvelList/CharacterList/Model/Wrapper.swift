//
//  Wrapper.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/13/21.
//

import Foundation

enum MarvelObject {
    case MarvelCharacter
}

// Note: Wrapper and Container keys are intentionally ommitted. Add desired keys as needed.

struct Wrapper: Decodable {
    let data: Container
}

struct Container: Decodable {
    let results: [MarvelCharacter]
}
