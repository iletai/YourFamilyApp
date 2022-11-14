//
//  AppRouterManager.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import Foundation
import SwiftUI

class AppRouterManager {
    static let shared = AppRouterManager()

    private var routerView = RouterView()

    private init() {
    }

    enum RouterState {
        case splash
        case home
        case setting
        case login
        case signUp
        case wallet
        case regist
        case forgotPassword
        case note
    }

    func getRouterView() -> some View {
        return routerView
    }

    func setRouterState(
        _ state: AppRouterManager.RouterState,
        transtion: AnyTransition? = nil,
        animation: Animation = .default
    ) {
        routerView.viewModel.changeRouterStatus(
            state: state,
            transtion: transtion,
            animation: animation
        )
    }
}
