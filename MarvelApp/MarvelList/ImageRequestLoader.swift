//
//  ImageRequestLoader.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import Foundation

class APIRequestLoader<T: APIProtocol> {
    let apiRequest: T
    let session: URLSession
 
    init(apiRequest: T, urlSession: URLSession = .shared) {
        self.apiRequest = apiRequest
        self.session = urlSession
    }
    
    func makeRequest(with requestData: T.RequestData, completion: @escaping (Result<T.ResponseDataType, Error>) -> Void) {
        let url = apiRequest.getURL(with: requestData)
        let request = URLRequest(url: url)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try self.apiRequest.parseResponse(fromJSON: data)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
