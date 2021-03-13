//
//  CharactersRequestAPITests.swift
//  MarvelAppTests
//
//  Created by Asaad Jaber on 3/13/21.
//

import XCTest
@testable import MarvelApp

class CharactersRequestAPITests: XCTestCase {
    let charactersAPI = CharacterRequestAPI()
    
    func testBuildCharactersURL() {
        let (timeStamp, hash) = URLAuth.computedAuthParams()
        let url = charactersAPI.getURL(with: (timeStamp, hash))
        
        XCTAssertEqual(url.scheme, "https")
        XCTAssertEqual(url.host, "gateway.marvel.com")
        XCTAssertEqual(url.query, "apikey=\(CharacterRequestAPI.publicKey)&ts=\(timeStamp)&hash=\(hash)&orderBy=name")
    }
}
