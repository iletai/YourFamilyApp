//
//  EndCodableExtension.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/10/22.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                as? [String: Any]
        else {
            throw NSError()
        }
        return dictionary
    }

    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap {
            $0 as? [String: Any]
        }
    }
}

enum EndCodableExtension {}
