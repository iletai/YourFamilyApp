//
//  LoginViewModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import FBSDKLoginKit
import Firebase
import Foundation
import LegacyCoreKit
import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var loginFacebookManager = LoginManager()
    @AppStorage(UserDefaultKey.loggedApp.rawValue) var loggedInApp = false
    @AppStorage(UserDefaultKey.emailLoggedIn.rawValue) var email = String.empty
    @Published var signUpProcessing = false
    @Published var yourPassword = String.empty
    @Published var repeatPassword = String.empty
    @Published var yourEmail = String.empty
    @Published var isSignUp = false

    init() {
        Settings.appID = AppConstant.kAppIdFacebook
        isSignUp = !loggedInApp
        if loggedInApp {
            moveToHome()
        }
    }
}

// MARK: - Function
extension LoginViewModel {
    /// Login Facebook
    func loginWithFacebook() {
        loginFacebookManager.logIn(
            permissions: AppConstant.kLoginParamRequest,
            from: nil
        ) { (result, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            } else {
                if !result!.isCancelled {
                    self.requestGrapFacebook()
                    self.loggedInApp = true
                }
            }
        }
    }

    private func requestGrapFacebook() {
        let request = GraphRequest(
            graphPath: "me",
            parameters: ["fields": "email"]
        )
        request.start { (_, res, _) in
            guard let profileDataUser = res as? [String: Any] else {
                return
            }
            self.email = profileDataUser["email"] as? String ?? .empty
            self.moveToHome()
            print("email" + self.email)
        }
    }

    private func moveToHome() {
        AppRouterManager.shared.setRouterState(.home)
    }

    func loginWithFirebase() {

    }

    func loginWithEmail() {
        
    }

    func signUpFirebase() {
        signUpProcessing = true
        Auth.auth().createUser(withEmail: yourEmail, password: yourPassword) { authResult, error in
            guard error == nil else {
                self.signUpProcessing = false
                return
            }
            switch authResult {
            case .none:  // Could not create account
                self.signUpProcessing = false
            case .some(_):
                self.signUpProcessing = false
                self.moveToHome()
            }
        }
    }

    public func isValidPassword(_ validateValue: String) -> Bool {
        let passwordRegex = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: validateValue)
    }
}
