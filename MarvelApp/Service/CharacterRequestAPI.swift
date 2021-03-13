//
//  CharacterRequestAPI.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/13/21.
//

import Foundation

enum Endpoint: String {
    case marvelCharacters = "/v1/public/characters"
}

struct CharacterRequestAPI {
    static let baseURLString = "https://gateway.marvel.com"
    static let publicKey = "91be37413fc85a2cc78a44cc20cceef9"
    static let privateKey = "fdfa044e4b83023b1705dec5cadaae08ab2bb9ed"
        
    func getURL(with authParams: (String, String)) -> URL {
        return CharacterRequestAPI.buildCharactersURL(endpoint: .marvelCharacters, authParams: authParams)
    }
    
    private static func buildCharactersURL(endpoint: Endpoint, authParams: (String, String)) -> URL {
        var components = URLComponents(string: baseURLString + endpoint.rawValue)!
                    
        components.queryItems = [
            URLQueryItem(name: "apikey", value: CharacterRequestAPI.publicKey),
            URLQueryItem(name: "ts", value: authParams.0),
            URLQueryItem(name: "hash", value: authParams.1),
            URLQueryItem(name: "orderBy", value: "name"),
        ]
                        
        return components.url!
    }
    
    func parseResponse(fromJSON data: Data) throws -> [MarvelCharacter] {
        let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
        return wrapper.data.results
    }
}
