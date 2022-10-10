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
    let emailAdress: String
    let phoneNumber: String

    var onBoarding: Bool

    init(id: String, emailAdress: String, phoneNumber: String, onBoarding: Bool) {
        self.id = id
        self.emailAdress = emailAdress
        self.phoneNumber = phoneNumber
        self.onBoarding = false
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