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
    @Published var isShowUpdateProfileView = false

    init() {
        DispatchQueue.main.async {
            if Auth.auth().currentUser?.uid != nil {
               self.getProfile()
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
    func getProfile() {
        FStorage
            .shared
            .firebaseReference(.user)
            .whereField(
                ServerConstant.Param.currentUser,
                isEqualTo: FUser.currentId()
            ).getDocuments { snapshot, error in
                if error == nil {
                    guard let snapshot else { return }
                    if !snapshot.isEmpty {
                        let userData = snapshot.documents.first!.data()
                        self.currentProfile = FUser(userData as NSDictionary)
                    } else {
                        let profile = UserDefaults.standard.object(forKey: ServerConstant.Param.currentUser)
                        if let dic = profile {
                            self.currentProfile = FUser(dic as! NSDictionary)
                        }
                    }
                } else {
                    // Show Error Toast
                    print(error?.localizedDescription ?? .empty)
                }
            }
    }

    func updateProfile(_ isShow: Bool) {
        isShowUpdateProfileView = isShow
    }

    func fetchUserImage() {
        DispatchQueue.main.async {
            self.getProfile()
            if let profile = self.currentProfile {
                FileStorage.downloadImage(imageUrl: profile.avatarImage, completion: { image in
                    self.userData.image = image
                })
            }
        }
    }

    func showActionSheetSignOut() {
        isShowActionSheet.toggle()
    }

    func signOut() {
        DispatchQueue.main.async {
            try? Auth.auth().signOut()
            SettingManager.loggedApp = false
            UserDefaults.standard.synchronize()
            AppRouterManager.shared.setRouterState(.login)
        }
    }

    func backToHome() {
        AppRouterManager.shared.setRouterState(.home)
    }

    func uploadFirebaseImage(_ image: UIImage) {
        let fileDirectory = "Avatars/" + "_\(FUser.currentId())" + ".jpg"
        if let profile = self.currentProfile {
            FileStorage.uploadImage(image, directory: fileDirectory) { documentLink in
                print(documentLink ?? .empty)
                profile.avatarImage = (documentLink ?? .empty) as String
                FStorage.shared
                    .firebaseReference(.user)
                    .document(FUser.currentId())
                    .updateData(FUserMapper.mapUserToFireStorage(profile)) { (error) in
                        if error == nil {
                            FileStorage.saveUserLocally(
                                userDictionary:
                                    FUserMapper.mapUserToFireStorage(profile) as NSDictionary
                            )
                        }
                    }
            }
        }
    }
}
