//
//  APIInterface.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/13/21.
//

import Foundation

protocol MarvelCharactersAPIProtocol {
    func getMarvelCharacters(completion: @escaping (Result<[MarvelCharacter], Error>) -> Void)
}
