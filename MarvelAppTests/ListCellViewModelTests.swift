//
//  ListCellViewModelTests.swift
//  MarvelAppTests
//
//  Created by Asaad Jaber on 3/15/21.
//

import XCTest
@testable import MarvelApp

class ListCellViewModelTests: XCTestCase {
    func testListCellViewModel() {
        let viewModel = ListCellViewModel(name: "Name", thumbnail: CharacterImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", imageExtension: "jpg"))
        
        XCTAssertEqual(viewModel.name, "Name")
        XCTAssertEqual(viewModel.imageURL, URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784/standard_fantastic.jpg"))
    }
}
