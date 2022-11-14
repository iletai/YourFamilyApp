//
//  UserDefaultExtension.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/10/22.
//

import Foundation

extension UserDefaults {
    func object<T: Codable>(
        _ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()
    ) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        if let data = UserDefaults.standard.dictionary(forKey: key),
        let dictData = try? JSONSerialization.data(withJSONObject: data) {
            return try? decoder.decode(type.self, from: dictData)
        }
        return try? decoder.decode(type.self, from: data)
    }

    func set<T: Codable>(
        object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()
    ) {
        if let data = try? encoder.encode(object) {
            _ = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            self.set(data, forKey: key)
        }
    }
}

enum UserDefaultExtension {}
