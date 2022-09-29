//
//  LoginView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import FBSDKLoginKit
import FacebookCore
import SwiftUI
import Combine

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var isStrongPassword = false
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
                        Text("Don't Have Account?")
                            .foregroundColor(Color.c232020)
                        Button {
                            AppRouterManager.shared.setRouterState(.signUp, animation: .easeOut(duration: 1))
                        } label: {
                            Text("Sign Up")
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
        .onOpenURL(perform: { url in
            ApplicationDelegate.shared.application(
                UIApplication.shared,
                open: url,
                sourceApplication: nil,
                annotation: UIApplication.OpenURLOptionsKey.annotation
            )
        })
        .onAppear {
            viewModel.moveToHome()
        }
        .environmentObject(viewModel)
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
                SecureField("Password", text: $viewModel.yourPassword)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(
                        Color.white.clipShape(RoundedRectangle(cornerRadius: 14))
                    )
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
                            viewModel.loginWithEmail()
                        }
                    },
                    label: {
                        HStack {
                            Image(systemName: "envelope")
                                .renderingMode(.template)
                                .frame(maxWidth: 24, maxHeight: 24)
                            Text("Login")
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
                Spacer(minLength: 100)
            }
            HStack {
                Spacer(minLength: 100)
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
                Spacer(minLength: 100)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
