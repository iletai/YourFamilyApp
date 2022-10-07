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

    init(_id: String, _emailAdress: String, _phoneNumber: String, _onBoarding: Bool) {
        id = _id
        emailAdress = _emailAdress
        phoneNumber = _phoneNumber
        onBoarding = false
    }

    class func currentUser() -> FUser? {
        if Auth.auth().currentUser != nil {
        }
        return nil
    }
}
