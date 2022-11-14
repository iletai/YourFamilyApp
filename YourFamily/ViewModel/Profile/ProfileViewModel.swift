//
//  ProfileViewModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/5/22.
//

import FacebookCore
import FacebookLogin
import FirebaseAuth
import Foundation
import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var showSettingProfile = false
    @Published var showMenuProfile = false
    @Published var isUserLoggedOut = false
    @Published var isShowActionSheet = false
    @Published var isShowPickerImage = false
    @Published var userData = UserData()
    @Published var currentProfile = FUser.emptyUser()
    @Published var isShowUpdateProfileView = false
    @Published var updateNickname = String.empty

    init() {
        if Auth.auth().currentUser?.uid != nil {
            self.getProfile()
        }
    }
}

// MARK: - Enum
extension ProfileViewModel {
}

// MARK: - Function
extension ProfileViewModel {
    // swiftlint:disable force_cast
    // swiftlint:disable legacy_objc_type
    func getProfile() {
        FStorage
            .shared
            .firebaseReference(.user)
            .whereField(
                ServerConstant.Param.currentUser,
                isEqualTo: FUser.currentId()
            )
            .getDocuments { snapshot, error in
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
            FileStorage.downloadImage(imageUrl: self.currentProfile.avatarImage) { image in
                self.userData.image = image
            }
        }
    }

    func showActionSheetSignOut() {
        isShowActionSheet.toggle()
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: ServerConstant.Param.currentUser)
            UserDefaults.standard.synchronize()
            AppRouterManager.shared.setRouterState(.login)
        } catch let error as Error {
            return
        }
    }

    func backToHome() {
        AppRouterManager.shared.setRouterState(.home)
    }

    func uploadFirebaseImage(_ image: UIImage) {
        let fileDirectory = "Avatars/" + "_\(FUser.currentId())" + ".jpg"
        FileStorage.uploadImage(image, directory: fileDirectory) { documentLink in
            print(documentLink ?? .empty)
            self.currentProfile.avatarImage = (documentLink ?? .empty) as String
            self.updateProfile()
        }
    }

    // swiftlint:disable legacy_objc_type
    func updateProfile() {
        if FUser.currentId().isEmpty {
            return
        }
        FStorage.shared
            .firebaseReference(.user)
            .document(FUser.currentId())
            .updateData(FUserMapper.mapUserToFireStorage(self.currentProfile)) { error in
                if error == nil {
                    FileStorage.saveUserLocally(
                        userDictionary:
                            FUserMapper.mapUserToFireStorage(self.currentProfile) as NSDictionary
                    )
                }
            }
    }
}
