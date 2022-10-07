//
//  File.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/7/22.
//

import Foundation

struct SeverConstant {
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
}
