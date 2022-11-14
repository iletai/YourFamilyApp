//
//  ForgotPasswordViewModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/25/22.
//

import Firebase
import Foundation

final class ForgotPasswordViewModel: ObservableObject {
    @Published var emailAdress = String.empty
    @Published var forgotPasswordInform = ForgotPasswordInform(title: .empty, message: .empty)
    @Published var isShowToast = false
    init() {
    }
}

// MARK: - Struct
extension ForgotPasswordViewModel {
    struct ForgotPasswordInform {
        let title: String
        let message: String
    }
}

// MARK: - Func
extension ForgotPasswordViewModel {
    func requestResetPassword() {
        if emailAdress.isEmpty {
            forgotPasswordInform = ForgotPasswordInform(
                title: "Warning!", message: "Your Emaill Adress Could Be Not Null"
            )
            isShowToast = true
            return
        } else {
            Auth.auth().sendPasswordReset(withEmail: emailAdress) { error in
                if let error = error {
                    self.forgotPasswordInform = ForgotPasswordInform(
                        title: "Error!",
                        message: error.localizedDescription
                    )
                } else {
                    self.forgotPasswordInform = ForgotPasswordInform(
                        title: "Sucess!",
                        message: "Request Change Password Sent!"
                    )
                }
                self.isShowToast = true
            }
        }
    }

    func isShowToast(_ isShow: Bool) {
        isShowToast = isShow
    }
}
