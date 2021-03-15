//
//  URLAuth.swift
//  MarvelAppTests
//
//  Created by Asaad Jaber on 3/13/21.
//

import Foundation
import CryptoKit

struct URLAuth {
    static func computedAuthParams() -> (String, String) {
        let timeStamp = "\(NSDate().timeIntervalSince1970 * 1000)"
        let md5Data = Insecure.MD5.hash(data: (timeStamp + CharacterRequestAPI.privateKey + CharacterRequestAPI.publicKey).data(using: .utf8)!)
        let md5Hex = md5Data.map { String(format: "%02hhx", $0) }.joined()
        return (timeStamp, md5Hex)
    }
}
