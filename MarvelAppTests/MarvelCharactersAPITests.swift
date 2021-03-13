//
//  MarvelCharactersAPITests.swift
//  MarvelAppTests
//
//  Created by Asaad Jaber on 3/13/21.
//

import XCTest
@testable import MarvelApp

class MarvelCharactersAPITests: XCTestCase {
    let charactersAPI = MarvelCharactersAPI(requestLoader: APIRequestLoader(apiRequest: CharacterRequestAPI()))

    func testGetMarvelCharactersAPICall() {
        let expectation = XCTestExpectation(description: "charactersAPI_Result")
        
        let currentMarvelCharactersCount = 20
        charactersAPI.getMarvelCharacters { (result) in
            switch result {
            case let .success(res):
                XCTAssertEqual(res.count, currentMarvelCharactersCount)
            case let .failure(error):
                print("Test Case Make Request Error: \(error)")
            }
            expectation.fulfill()
        }
    
        wait(for: [expectation], timeout: 5)
    }
}
