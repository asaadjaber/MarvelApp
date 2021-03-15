//
//  ImageStore.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import UIKit

struct ImageStoreAPI: APIProtocol {
    func getURL(with url: URL) -> URL {
        return ImageStoreAPI.imageURL(url: url)
    }
    
    private static func imageURL(url: URL) -> URL {
        return url
    }
    
    func parseResponse(fromJSON data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
