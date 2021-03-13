//
//  MarvelAPIProtocol.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/13/21.
//

import Foundation

protocol APIProtocol {
    associatedtype ResponseDataType
    associatedtype RequestData
    
    func getURL(with _: RequestData) -> URL
    func parseResponse(fromJSON data: Data) throws -> ResponseDataType
}
