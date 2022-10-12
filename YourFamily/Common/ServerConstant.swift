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
        static var storageURL = "gs://yourfamily-562e9.appspot.com"
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
        /// nickname
            static let nickname = "nickname"
        /// firstname
            static let firstName = "firstname"
        /// lastname
            static let lastName = "lastname"
        /// fullname
            static let fullName = "fullname"
        /// currentUser
            static let currentUser = "currentUser"
        /// fullAdress
            static let fullAdress = "fullAddress"
        /// phoneNumber
            static let phoneNumber = "phoneNumber"
        /// onBoard
            static let onBoard = "onBoard"
        /// me
            static let me = "me"
        /// email
            static let email = "email"
        /// ["fields": "email"]
            static let paramRequest = ["fields": "email"]
        /// birthday
            static let birthday = "birthday"
        /// avatarImage
            static let avatarImage = "avatarImage"
        #else
        #endif
    }
}
