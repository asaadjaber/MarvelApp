//
//  ImageURLBuilder.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/15/21.
//

import Foundation

struct ImageURLBuilder {
    enum AspectRatio: String {
        case square = "standard"
        case detail
    }

    enum SquareSize: String {
        case small
        case fantastic
    }
   
    static func getURL(with attributes: (CharacterImage, AspectRatio, SquareSize?)) -> URL {
        let (thumbnail, aspectRatio, size) = attributes
        var variantPath = aspectRatio.rawValue
        if let size = size {
            variantPath += "_" + size.rawValue
        }
        
        return URL(string: thumbnail.path + "/\(variantPath)" + ".\(thumbnail.imageExtension)")!
    }
}
