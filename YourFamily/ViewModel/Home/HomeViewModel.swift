//
//  HomeViewModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/26/22.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var tabViewCurrentIndex = 1
    @Published var tabItem = HomeTabView.allCases
    init() {
    }
}

// MARK: - Enum
extension HomeViewModel {
    enum HomeTabView: Hashable, CaseIterable, Identifiable {
        var id: Self {
            self
        }

        case home
        case memories
        case profile
        case setting

        var tabIndexValue: Int {
            switch self {
            case .home:
                return 0
            case .memories:
                return 1
            case .profile:
                return 2
            case .setting:
                return 3
            }

        }
    }

}

