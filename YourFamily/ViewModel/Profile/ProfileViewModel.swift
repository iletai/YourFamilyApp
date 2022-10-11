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
    @Published var currentProfile: FUser?

    init() {
        DispatchQueue.main.async {
            if Auth.auth().currentUser?.uid != nil {
                self.currentProfile = self.getProfile()
            }
        }
    }
}

// MARK: - Enum
extension ProfileViewModel {
}

// MARK: - Function
extension ProfileViewModel {
    // swiftlint:disable force_cast
    func getProfile() -> FUser? {
        let profile = UserDefaults.standard.object(forKey: ServerConstant.Param.currentUser)
        if let dic = profile {
            return FUser(dic as! NSDictionary)
        }
        return nil
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
        SettingManager.loggedApp = false
        AppRouterManager.shared.setRouterState(.login)
    }

    func backToHome() {
        AppRouterManager.shared.setRouterState(.home)
    }
}
