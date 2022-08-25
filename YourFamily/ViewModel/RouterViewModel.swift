//
//  RouterViewModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import SwiftUI

final class RouterViewModel: ObservableObject {
    @Published var state: AppRouterManager.RouterState = .splash
    @Published var transition: AnyTransition = .identity

    func changeRouterStatus(state: AppRouterManager.RouterState,
                            transtion: AnyTransition?,
                            animation: Animation) {
        if let transtion = transtion {
            self.transition = .asymmetric(insertion: transtion, removal: .opacity)
        } else {
            self.transition = .identity
        }
        withAnimation(animation) {
            self.state = state
        }
    }
}
