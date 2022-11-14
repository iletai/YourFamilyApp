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
            static var baseURL =
                "https://yourfamily-562e9-default-rtdb.asia-southeast1.firebasedatabase.app"
            static var storageURL = "gs://yourfamily-562e9.appspot.com"
        #else
        #endif
    }

    enum FirebasePathAPI: String {
        case login = "/login"
        case regist = "/register"
        case profile = "/users-profile"
    }

    // swiftlint:disable identifier_name
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
            /// Memory Id
            static let memoryId = "memory_id"
            /// Memory Title
            static let memoryTitle = "memory_title"
            /// memory.imageLink
            static let memoryImageLink = "memory_imageLink"
            /// Memory Location
            static let memoryLocation = "memory_location"
            /// Memory Time
            static let memoryTime = "memory_time"
            /// Note Title
            static let noteTitle = "note_title"
            /// Note Cost
            static let noteCost = "note_cost"
            /// Note Date
            static let noteDate = "note_date"
            /// Note Id
            static let noteId = "note_id"
            /// Note Cash In
            static let noteCashIn = "note_cash"
        #else
        #endif
    }
}
