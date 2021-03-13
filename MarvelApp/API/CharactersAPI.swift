//
//  CharactersAPI.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/13/21.
//

import Foundation

struct MarvelCharactersAPI: MarvelCharactersAPIProtocol {
    let requestLoader: APIRequestLoader<CharacterRequestAPI>
    
    init(requestLoader: APIRequestLoader<CharacterRequestAPI>) {
        self.requestLoader = requestLoader
    }
    
    func getMarvelCharacters(completion: @escaping (Result<[MarvelCharacter], Error>) -> Void) {
        requestLoader.makeRequest(with: URLAuth.computedAuthParams()) { (result) in
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
    }
}
