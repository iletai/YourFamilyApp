//
//  LoginViewModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import FBSDKLoginKit
import Firebase
import Foundation
import SwiftUI
import FirebaseAuth

final class LoginViewModel: ObservableObject {
    @Published var loginFacebookManager = LoginManager()
    @AppStorage(UserDefaultKey.loggedApp.rawValue) var loggedInApp = false
    @AppStorage(UserDefaultKey.emailLoggedIn.rawValue) var email = String.empty
    @Published var signUpProcessing = false
    @Published var yourPassword = String.empty
    @Published var repeatPassword = String.empty
    @Published var yourEmail = String.empty
    @Published var isSignUp = false
    @Published var isShowError = false
    @Published var authenError = AuthencationError(title: .empty, message: .empty)

    init() {
        Settings.appID = AppConstant.kAppIdFacebook
        isSignUp = !loggedInApp
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

// MARK: - Struct
extension LoginViewModel {
    struct AuthencationError {
        let title: String
        let message: String
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
                    DispatchQueue.main.async {
                        self.requestGrapFacebook(result: result!)
                    }
                }
            }
        }
    }

    private func requestGrapFacebook(result: LoginManagerLoginResult) {
        let request = GraphRequest(
            graphPath: ServerConstant.Param.me,
            parameters: ServerConstant.Param.paramRequest
        )
        request.start { (_, res, _) in
            guard let profileDataUser = res as? [String: Any],
                  let token = AccessToken.current?.tokenString else {
                return
            }
            SettingManager.emailLoggedIn =
                profileDataUser[ServerConstant.Param.email] as? String ?? .empty
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            Auth.auth().signIn(with: credential) { res, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let res else {
                    return
                }
                FStoreage.shared
                    .firebaseReference(.user)
                    .document(FUser.currentId())
                    .getDocument(completion: { snapShot, error in
                    guard let snapShot else {
                        return
                    }
                    if snapShot.exists {
                        self.saveUserLocally(userDictionary: snapShot.data()! as NSDictionary)
                        self.loggedInApp = true
                        self.moveToHome()
                    } else {
                        let user = FUser(
                            id: FUser.currentId(),
                            emailAdress: profileDataUser[ServerConstant.Param.email] as? String ?? .empty,
                            phoneNumber: res.user.phoneNumber ?? .empty,
                            onBoarding: true
                        )
                        FStoreage.shared
                            .firebaseReference(.user)
                            .document(FUser.currentId())
                            .setData(FUserMapper.mapUserToFireStorage(user)) { (error) in
                                if error == nil {
                                    self.loggedInApp = true
                                    self.moveToHome()
                                }
                        }
                    }
                })
            }
        }
    }

    func moveToHome() {
        if loggedInApp {
            AppRouterManager.shared.setRouterState(.home)
        }
    }

    func saveUserLocally(userDictionary: NSDictionary) {
        UserDefaults.standard.set(userDictionary, forKey: ServerConstant.Param.currentUser)
        UserDefaults.standard.synchronize()
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
            print(res?.user.displayName ?? .empty)
        }
    }

    func loginWithEmail() {
        guard !yourEmail.isEmpty, !yourPassword.isEmpty else {
            isShowError = true
            return
        }
        Auth.auth().signIn(withEmail: yourEmail, password: yourPassword) { authResult, error in
            guard error == nil else {
                self.loggedInApp = false
                return
            }
            if authResult!.user.isEmailVerified {
            } else {
                self.authenError = AuthencationError(
                    title: "Notice", message: "Your email adress not yet verify!")
                authResult!.user.sendEmailVerification { (error) in
                    if let error = error {
                        print("Verification email sent error is: ", error.localizedDescription)
                    }
                }
                self.isShowError = true
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
            authResult!.user.sendEmailVerification { (error) in
                print("Verification email sent error is: ", error!.localizedDescription)
            }
        }
    }

    // swiftlint:disable line_length
    public func isValidPassword(_ validateValue: String) -> Bool {
        let passwordRegex =
            "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: validateValue)
    }
}
