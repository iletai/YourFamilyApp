//
//  ForgotPassword.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/25/22.
//

import AlertToast
import SwiftUI

struct ForgotPassword: View {
    @StateObject private var viewModel = ForgotPasswordViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Image("forgotpass")
                .resizable()
                .scaledToFit()

            Text("Forgot Password")
                .font(.system(.title))
                .fontWeight(.bold)
                .frame(alignment: .leading)
                .padding(.bottom, 20)
            Text("Please enter your email, we will send request change password via email adress")
                .font(.system(size: 14))
            TextField(text: $viewModel.emailAdress) {
                Text("Your Email Adress")
            }
            .padding()
            .background(
                Color.c745CF1
                    .cornerRadius(20)
                    .opacity(0.2)
                    .shadow(color: Color.c051937, radius: 2, x: 0, y: 2)
            )
            .padding(.bottom, 20)
            Button {
                viewModel.requestResetPassword()
            } label: {
                Text("Confirm Reset Password")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        Color.c745CF1.opacity(0.7).cornerRadius(20)
                    )
            }
        }
        .toast(
            isPresenting: $viewModel.isShowToast,
            tapToDismiss: false,
            alert: {
                AlertToast(
                    type: .regular,
                    title: viewModel.forgotPasswordInform.title,
                    subTitle: viewModel.forgotPasswordInform.message
                )
            },
            completion: {
                viewModel.isShowToast(false)
            }
        )
        .padding()
    }
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassword()
    }
}
