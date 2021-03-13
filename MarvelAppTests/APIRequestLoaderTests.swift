//
//  APIRequestLoaderTests.swift
//  MarvelAppTests
//
//  Created by Asaad Jaber on 3/13/21.
//

import XCTest
@testable import MarvelApp

class APIRequestLoaderTests: XCTestCase {
    var requestLoader: APIRequestLoader<CharacterRequestAPI>!
    
    override func setUp() {
        let request = CharacterRequestAPI()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        requestLoader = APIRequestLoader(apiRequest: request, urlSession: urlSession)
    }
        
    func testAPIRequestLoaderSuccess() {
        let mockJSONData = """
        {"data":
            {"results":
                [
                    {
                    "name": "someName",
                    "description": "someDescription",
                    "thumbnail":
                        {
                        "path": "somePath",
                         "extension": "someExtension"
                        }
                    }
                ]
            }
        }
        """.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockJSONData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        requestLoader.makeRequest(with: URLAuth.computedAuthParams()) { (result) in
            switch result {
            case let .success(characters):
                XCTAssertEqual(characters.first!.name, "someName")
            case let .failure(error):
                print("testLoaderSuccess() Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
}
