//
//  LoginViewModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import Foundation
import FBSDKLoginKit
import SwiftUI
import LegacyCoreKit

final class LoginViewModel: ObservableObject {
    @Published var loginFacebookManager = LoginManager()
    @AppStorage(AppConstant.kLoginKeySave) var loggedInApp = true
    @AppStorage(AppConstant.kLoginEmail) var email = String.empty

    init() {
        Settings.appID = AppConstant.kAppIdFacebook
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
            from: nil) { (result, error) in
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
        }
    }

    private func moveToHome() {
        AppRouterManager.shared.setRouterState(.home)
    }
}
