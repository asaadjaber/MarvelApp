//
//  ImageAPI.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import UIKit

struct ImageAPI {
    private let requestLoader: APIRequestLoader<ImageStoreAPI>
    
    init(requestLoader: APIRequestLoader<ImageStoreAPI>) {
        self.requestLoader = requestLoader
    }
            
    func requestImage(withURL: URL, completion: @escaping (UIImage?) -> Void) {
        requestLoader.makeRequest(with: withURL) { (res) in
            OperationQueue.main.addOperation {
                switch res {
                case let .success(image):
                   completion(image)
                case .failure:
                    completion(nil)
                }
            }
        }
    }
}
