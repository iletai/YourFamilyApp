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
    @Published var yourPassword = String.empty
    @Published var repeatPassword = String.empty
    @Published var yourEmail = String.empty
    @Published var isSignUp = false
    @Published var isShowError = false
    @Published var authenError = AuthencationError(title: .empty, message: .empty)
    @Published var isShowPassword = false
    @Published var isShowRepeatPassword = false

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

    enum PasswordState {
        case secure
        case unsecure
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
                } else {
                    self.authenError = AuthencationError(
                        title: "Error!",
                        message: "You was cancel login with Facebook!"
                    )
                    self.isShowError = true
                }
            }
        }
    }

    func isShowToast(_ isShow: Bool) {
        isShowError = isShow
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
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            Auth.auth().signIn(with: credential) { res, error in
                if let error = error {
                    self.isShowError = true
                    self.authenError = AuthencationError(title: "Error!", message: error.localizedDescription)
                    return
                }
                guard let res else { return }
                FStorage.shared
                    .firebaseReference(.user)
                    .document(FUser.currentId())
                    .getDocument(completion: { snapShot, error in
                    guard let snapShot else {
                        return
                    }
                    if snapShot.exists {
                        FileStorage.saveUserLocally(userDictionary: snapShot.data()! as NSDictionary)
                        self.loggedInApp = true
                        self.moveToHome()
                    } else {
                        let user = FUser(
                            id: FUser.currentId(),
                            nickname: .empty,
                            emailAdress: profileDataUser[ServerConstant.Param.email] as? String ?? .empty,
                            phoneNumber: res.user.phoneNumber ?? .empty,
                            avatarImage: .empty,
                            onBoarding: true,
                            birthday: Date()
                        )

                        FStorage.shared
                            .firebaseReference(.user)
                            .document(FUser.currentId())
                            .setData(FUserMapper.mapUserToFireStorage(user)) { (error) in
                                if error == nil {
                                    self.loggedInApp = true
                                    FileStorage.saveUserLocally(
                                        userDictionary:
                                            FUserMapper.mapUserToFireStorage(user) as NSDictionary
                                    )
                                    self.moveToHome()
                                }
                        }
                    }
                })
            }
        }
    }

    func moveToHome() {
        DispatchQueue.main.async {
            if Auth.auth().currentUser != nil {
                AppRouterManager.shared.setRouterState(.home)
            }
        }
    }

    func loginWithEmail() {
        guard !yourEmail.isEmpty, !yourPassword.isEmpty else {
            isShowError = true
            authenError = AuthencationError(title: "Warning!", message: "Your Infomation Could Be Not Null")
            return
        }
        Auth.auth().signIn(withEmail: yourEmail, password: yourPassword) { authResult, error in
            guard error == nil else {
                return
            }
            if authResult!.user.isEmailVerified {
                FStorage.shared
                    .firebaseReference(.user)
                    .document(FUser.currentId())
                    .getDocument(completion: { snapShot, error in
                        guard let snapShot else { return }
                        if snapShot.exists {
                            self.loggedInApp = true
                            self.moveToHome()
                        } else {
                            let user = FUser(
                                id: FUser.currentId(),
                                nickname: .empty,
                                emailAdress: authResult?.user.email ?? .empty,
                                phoneNumber: authResult?.user.phoneNumber ?? .empty,
                                avatarImage: .empty,
                                onBoarding: true,
                                birthday: Date()
                            )
                            FStorage.shared
                                .firebaseReference(.user)
                                .document(FUser.currentId())
                                .setData(FUserMapper.mapUserToFireStorage(user)) { (error) in
                                    if error == nil {
                                        FileStorage.saveUserLocally(
                                            userDictionary: FUserMapper
                                                .mapUserToFireStorage(user) as NSDictionary
                                        )
                                        self.loggedInApp = true
                                        self.moveToHome()
                                    }
                                }
                        }
                    })

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
        }
    }

    func signUpFirebase() {
        if yourEmail.isEmpty || yourPassword.isEmpty || repeatPassword.isEmpty {
            authenError = AuthencationError(title: "Incorrect!", message: "Your Infomation Could Be Not Empty!")
            isShowError = true
            return
        }
        Auth.auth().createUser(withEmail: yourEmail, password: yourPassword) { authResult, error in
            guard error == nil else {
                self.isShowError = true
                self.authenError = AuthencationError(title: "Error!", message: error?.localizedDescription ?? .empty)
                return
            }
            authResult!.user.sendEmailVerification { (error) in
                if let error = error {
                    self.authenError = AuthencationError(
                        title: "Error",
                        message: error.localizedDescription
                    )
                } else {
                    self.authenError = AuthencationError(
                        title: "Notice",
                        message: "Please verify your email for sign up!"
                    )
                }
                self.isShowError = true
                return
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
