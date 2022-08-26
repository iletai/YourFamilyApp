//
//  LoginView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import FBSDKLoginKit
import FacebookCore
import SwiftUI

struct LoginView: View {
    private(set) var viewModel = LoginViewModel()

    var body: some View {
        ZStack {
            Color(hex: "F1F3F6").ignoresSafeArea()
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.red)
                    .frame(maxWidth: 96, maxHeight: 96)
                    .redacted(reason: .placeholder)
                Text("Your Family")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "3D6670"))
                Spacer()
                Button(
                    action: {
                        withAnimation(.easeOut) {
                            viewModel.loginWithFacebook()
                        }
                    },
                    label: {
                        HStack {
                            Image("facebook")
                            Text("Login with Facebook")
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1))
                    })
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
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
