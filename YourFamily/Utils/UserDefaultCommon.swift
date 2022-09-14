//
//  UserDefaultCommon.swift
//  TaiLe
//
//  Created by Lê Quang Trọng Tài on 2/16/22.
//

import Foundation

enum UserDefaultKey: String {
    case finishOnboarding
    case currentTheme
    case showDateOut
    case darkMode
    case showLunar
    case calendarViewMode
    case dateStartOfWeek
    case loggedApp
    case emailLoggedIn

    var stringValue: String {
        "UserDefaultsDataStore.Key.\(self.rawValue)"
    }
}

@propertyWrapper
struct UserDefault<T> {
    let key: UserDefaultKey
    let defaultValue: T
    init(_ key: UserDefaultKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key.stringValue) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.stringValue)
        }
    }
}
