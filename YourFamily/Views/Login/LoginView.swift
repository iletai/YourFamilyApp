//
//  LoginView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import AlertToast
import Combine
import FBSDKLoginKit
import FacebookCore
import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @FocusState var focused: LoginViewModel.PasswordState?

    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "F1F3F6").ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("login_image")
                        .resizable()
                        .scaledToFit()
                    VStack {
                        Text("Your Family")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "3D6670"))
                            .shadow(color: .blue, radius: 1, x: 0, y: 2)
                        VStack(spacing: 16) {
                            makeTextInputArea()
                            makeButtonArea()
                            Spacer()
                            HStack {
                                Text("Don't Have Account?")
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.c232020)
                                Button {
                                    AppRouterManager.shared.setRouterState(
                                        .signUp, animation: .easeOut(duration: 1))
                                } label: {
                                    Text("Sign Up")
                                        .font(.system(size: 12))
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(
                                            RoundedRectangle(cornerRadius: 25).strokeBorder(
                                                Color.blue, lineWidth: 2)
                                        )
                                }
                            }
                        }
                    }
                    .background(
                        Color(hex: "F1F3F6")
                            .cornerRadius(20, corners: [.topLeft, .topRight])
                    )
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .onOpenURL(perform: { url in
                ApplicationDelegate.shared.application(
                    UIApplication.shared,
                    open: url,
                    sourceApplication: nil,
                    annotation: UIApplication.OpenURLOptionsKey.annotation
                )
            })
            .toast(
                isPresenting: $viewModel.isShowError,
                tapToDismiss: false,
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
        .environmentObject(viewModel)
        }
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

    func makeButtonArea() -> some View {
        VStack {
            HStack {
                Spacer(minLength: 100)
                loginEmailButton
                Spacer(minLength: 100)
            }
            makeLableOr()
            HStack {
                Spacer(minLength: 100)
                facebookLoginButton
                Spacer(minLength: 100)
            }
            NavigationLink {
                ForgotPassword()
            } label: {
                Text("Forgot the password?")
                    .font(.system(.callout))
                    .fontWeight(.bold)
                    .foregroundColor(Color.c745CF1)
                    .padding(.top, 20)
            }
        }
    }

    var loginEmailButton: some View {
        Button(
            action: {
                withAnimation(.easeOut) {
                    viewModel.loginWithEmail()
                }
            },
            label: {
                HStack {
                    Image(systemName: "envelope")
                        .renderingMode(.template)
                        .frame(maxWidth: 24, maxHeight: 24)
                    Text("Login with Email")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16).fill(Color.c745CF1)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                )
            })
    }

    var facebookLoginButton: some View {
        Button(
            action: {
                withAnimation(.easeOut) {
                    viewModel.loginWithFacebook()
                }
            },
            label: {
                HStack {
                    Image("facebook")
                        .frame(maxWidth: 24, maxHeight: 24)
                    Text("Login with Facebook")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16).fill(Color.c5CCBF1)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                )
                .frame(maxWidth: .infinity)
            })
    }

    func makeLableOr() -> some View {
        ZStack {
            Divider()
                .padding(.horizontal, 32)
            Circle()
                .strokeBorder(Color.gray, lineWidth: 0.5)
                .background(Circle().foregroundColor(Color(hex: "F1F3F6")))
                .frame(width: 24, height: 24)
            Text("OR")
                .font(.system(size: 8))
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .padding(8)
                .zIndex(1)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
