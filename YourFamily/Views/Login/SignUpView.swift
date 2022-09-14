//
//  SignUpView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/14/22.
//

import SwiftUI

struct SignUpView: View {
    @State private(set) var viewModel = LoginViewModel()

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
                            .foregroundColor(Color.c232020)
                        Button {
                            AppRouterManager.shared.setRouterState(.login, animation: .easeOut(duration: 1))
                        } label: {
                            Text("Login")
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
            HStack {
                Spacer(minLength: 24)
                SecureField("Repeat Password", text: $viewModel.yourPassword)
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
                            viewModel.loginWithFacebook()
                        }
                    },
                    label: {
                        HStack(spacing: 8) {
                            Image(systemName: "envelope")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .frame(maxWidth: 24, maxHeight: 24)
                            Text("Sign Up")
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
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
