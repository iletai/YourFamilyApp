//
//  LoginView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import FacebookCore
import SwiftUI
import FBSDKLoginKit

struct LoginView: View {
    private(set) var viewModel = LoginViewModel()

    var body: some View {
        ZStack {
            Button(action: {
                viewModel.loginWithFacebook()
            }, label: {
                Text("Loggin App")
            })
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
