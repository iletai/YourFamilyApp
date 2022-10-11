//
//  SignUpView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/14/22.
//

import AlertToast
import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = LoginViewModel()
    @FocusState var focused: LoginViewModel.PasswordState?

    var body: some View {
        ZStack {
            Color(hex: "F1F3F6").ignoresSafeArea()
            VStack {
                Spacer()
                Color.red
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(maxWidth: 96, maxHeight: 96)
                Text("Your Family")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "3D6670"))
                VStack(spacing: 16) {
                    makeTextInputArea()
                    makeButtonArea()
                    Spacer()
                    HStack {
                        Text("Already Account?")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color.c232020)
                        Button {
                            AppRouterManager.shared.setRouterState(.login, animation: .easeOut(duration: 1))
                        } label: {
                            Text("Login")
                                .font(.system(size: 12))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 25) .strokeBorder(Color.blue, lineWidth: 2)
                                )
                        }
                    }
                }
                Spacer()
            }
        }
        .toast(
            isPresenting: $viewModel.isShowError,
            alert: {
                AlertToast(
                    type: .regular,
                    title: viewModel.authenError.title,
                    subTitle: viewModel.authenError.message
                )
            },
            completion: {
                viewModel.isShowToast(false)
            }
        )
    }

    func makeTextInputArea() -> some View {
        Group {
            HStack {
                Spacer(minLength: 24)
                TextField("Email", text: $viewModel.yourEmail)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(
                        Color.white.clipShape(RoundedRectangle(cornerRadius: 14))
                    )
                Spacer(minLength: 24)
            }
            HStack {
                Spacer(minLength: 24)
                makePasswordInputView()
                Spacer(minLength: 24)
            }
            HStack {
                Spacer(minLength: 24)
                makeRepeatPassword()
                Spacer(minLength: 24)
            }
        }
    }

    func makeButtonArea() -> some View {
        VStack {
            HStack {
                Spacer(minLength: 100)
                Button(
                    action: {
                        withAnimation(.easeOut) {
                            viewModel.signUpFirebase()
                        }
                    },
                    label: {
                        HStack(spacing: 8) {
                            Image(systemName: "envelope")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .frame(maxWidth: 24, maxHeight: 24)
                            Text("Sign Up With Email")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16).fill(Color.c745CF1)
                                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        )
                    })
                Spacer(minLength: 100)
            }
        }
    }

    func makePasswordInputView() -> some View {
        ZStack {
            TextField("Password", text: $viewModel.yourPassword)
                .focused($focused, equals: .unsecure)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.alphabet)
                .opacity(viewModel.isShowPassword ? 1 : 0)
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
            SecureField("Password", text: $viewModel.yourPassword)
                .focused($focused, equals: .secure)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.alphabet)
                .opacity(viewModel.isShowPassword ? 0 : 1)
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
        }
        .background(
            Color.white.clipShape(RoundedRectangle(cornerRadius: 14))
        )
        .overlay {
            HStack {
                Spacer()
                Button(action: {
                    viewModel.isShowPassword.toggle()
                    focused = focused == .secure ? .unsecure : .secure
                }, label: {
                    Image(systemName: self.viewModel.isShowPassword ? "eye.slash.fill" : "eye.fill")
                        .padding()
                })

            }
        }
    }

    func makeRepeatPassword() -> some View {
        ZStack {
            TextField("Repeat Password", text: $viewModel.repeatPassword)
                .focused($focused, equals: .unsecure)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.alphabet)
                .opacity(viewModel.isShowRepeatPassword ? 1 : 0)
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
            SecureField("Repeat Password", text: $viewModel.repeatPassword)
                .focused($focused, equals: .secure)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.alphabet)
                .opacity(viewModel.isShowRepeatPassword ? 0 : 1)
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
        }
        .background(
            Color.white.clipShape(RoundedRectangle(cornerRadius: 14))
        )
        .overlay {
            HStack {
                Spacer()
                Button(action: {
                    viewModel.isShowRepeatPassword.toggle()
                    focused = focused == .secure ? .unsecure : .secure
                }, label: {
                    Image(systemName: self.viewModel.isShowRepeatPassword ? "eye.slash.fill" : "eye.fill")
                        .padding()
                })

            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
