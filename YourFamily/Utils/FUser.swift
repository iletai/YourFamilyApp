//
//  FUser.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/6/22.
//

import FirebaseAuth
import Foundation

class FUser {
    let id: String
    var nickname: String
    let emailAdress: String
    let phoneNumber: String
    var avatarImage: String
    var bithday: Date
    var onBoarding: Bool

    init(id: String,
         nickname: String,
         emailAdress: String,
         phoneNumber: String,
         avatarImage: String,
         onBoarding: Bool,
         birthday: Date
    ) {
        self.id = id
        self.emailAdress = emailAdress
        self.nickname = nickname
        self.phoneNumber = phoneNumber
        self.avatarImage = avatarImage
        self.onBoarding = false
        self.bithday = birthday
    }

    init(_ dictionary: NSDictionary) {
        id = dictionary[ServerConstant.Param.currentUser] as? String ?? .empty
        nickname = dictionary[ServerConstant.Param.nickname] as? String ?? .empty
        emailAdress = dictionary[ServerConstant.Param.email] as? String ?? .empty
        phoneNumber = dictionary[ServerConstant.Param.phoneNumber] as? String ?? .empty
        onBoarding = dictionary[ServerConstant.Param.onBoard] as? Bool ?? false
        bithday = dictionary[ServerConstant.Param.birthday] as? Date ?? Date()
        avatarImage = dictionary[ServerConstant.Param.avatarImage] as? String ?? .empty
    }

    class func currentUser() -> FUser? {
        if Auth.auth().currentUser != nil {
        }
        return nil
    }

    class func currentId() -> String {
        return Auth.auth().currentUser!.uid
    }
}
