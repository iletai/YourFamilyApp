//
//  RouterView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import SwiftUI

struct RouterView: View {
    @ObservedObject var viewModel = RouterViewModel()

    var body: some View {
        switch viewModel.state {
        case .splash:
            ContentView().transition(viewModel.transition)
        case .forgotPassword:
            EmptyView()
        case .home:
            HomeView().transition(viewModel.transition)
        case .note:
            EmptyView()
        case .regist:
            EmptyView()
        case .wallet:
            EmptyView()
        case .setting:
            EmptyView()
        case .login:
            LoginView()
        }
    }
}
