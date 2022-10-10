//
//  File.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/7/22.
//

import Foundation

struct ServerConstant {
    struct BaseAPIURL {
        #if DEBUG
        static var baseURL = "https://yourfamily-562e9-default-rtdb.asia-southeast1.firebasedatabase.app"
        #else
        #endif
    }

    enum FirebasePathAPI: String {
        case login = "/login"
        case regist = "/register"
        case profile = "/users-profile"
    }

    struct Param {
        #if DEBUG
        /// me
            static var me = "me"
        /// email
            static var email = "email"
        /// ["fields": "email"]
            static var paramRequest = ["fields": "email"]
        #else
        #endif
    }
}
