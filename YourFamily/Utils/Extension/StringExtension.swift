//
//  File.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import Foundation

extension String {
    static var empty: String {
        return ""
    }

    var toLocalizeString: String {
        Bundle.Current.localizedString(forKey: self)
    }
}

enum StringExtension {}
