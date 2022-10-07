//
//  ProfileViewModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/5/22.
//

import FacebookCore
import FacebookLogin
import Foundation
import SwiftUI
import FirebaseAuth

final class ProfileViewModel: ObservableObject {
    @Published var showSettingProfile = false
    @Published var showMenuProfile = false
    @Published var username = SettingManager.emailLoggedIn
    @Published var isUserLoggedOut = false
    @Published var isShowActionSheet = false
    @Published var isShowPickerImage = false
    @Published var userData = UserData()
    @Published var storageManager = FileStoreManager()

    init() {
        DispatchQueue.main.async {
            self.isUserLoggedOut = Auth.auth().currentUser?.uid == nil
        }
    }
}

// MARK: - Enum
extension ProfileViewModel {
}

// MARK: - Function
extension ProfileViewModel {
    func getProfileImage() {
    }

    func fetchUserImage() {
        DispatchQueue.main.async {
            self.userData.image = self.storageManager.getListStorage()
        }
    }

    func showActionSheetSignOut() {
        isShowActionSheet.toggle()
    }

    func signOut() {
        try? Auth.auth().signOut()
        AppRouterManager.shared.setRouterState(.login)
    }

    func backToHome() {
        AppRouterManager.shared.setRouterState(.home)
    }
}
