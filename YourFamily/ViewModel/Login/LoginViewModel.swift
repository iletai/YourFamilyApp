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

// MARK: - Enum
extension LoginViewModel {
    enum AuthencationState: CaseIterable, Identifiable {
        var id: Self {
            self
        }

        case none
        case signIn
        case signOut
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
                    self.requestGrapFacebook(result: result!)
                }

            }
        }
    }

    private func requestGrapFacebook(result: LoginManagerLoginResult) {
        let request = GraphRequest(
            graphPath: "me",
            parameters: ["fields": "email"]
        )
        request.start { (_, res, _) in
            guard let profileDataUser = res as? [String: Any] else {
                return
            }
            // self.loggedInApp = true
            self.email = profileDataUser["email"] as? String ?? .empty
            guard let token = AccessToken.current?.tokenString else {
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            Auth.auth().signIn(with: credential) { res, error in
                if let error = error {
                    print(error)
                    return
                }
                self.loggedInApp = true

            }
            self.moveToHome()
            print("email" + self.email)
        }
    }

    private func moveToHome() {
        AppRouterManager.shared.setRouterState(.home)
    }

    func loginWithFirebase() {
        guard let token = AccessToken.current?.tokenString else {
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        Auth.auth().signIn(with: credential) { res, error in
            if let error = error {
                print(error)
                return
            }

        }
    }

    func loginWithEmail() {
        Auth.auth().signIn(withEmail: yourEmail, password: yourPassword) { authResult, error in
            guard error == nil else {
                self.loggedInApp = false
                return
            }
            switch authResult {
            case .none:  // Could not create account
                self.signUpProcessing = false
            case .some:
                self.loggedInApp = true
                self.moveToHome()
            }
        }
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
            case .some:
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
