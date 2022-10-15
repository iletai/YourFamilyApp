//
//  LunarCalendarViewModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import CVCalendar
import CoreGraphics
import Foundation

final class LunarCalendarViewModel: ObservableObject {
    @Published var date = Date()
    @Published var isShowSetting = false
    @Published var isShowAddMemory = false
    @Published var memory = OnThisDayModel.empty()
    @Published var titleMemory = String.empty
    @Published var travelOnTime = Date()
    @Published var location = String.empty
    @Published var userData = UserData()
    @Published var isShowPickerImage = false
    @Published var showingToastInform = false
    @Published var floatToastInfo = InformFloatToast(title: .empty, message: .empty)

    init() {
    }
}

// MARK: - Struct
extension LunarCalendarViewModel {
    struct InformFloatToast {
        let title: String
        let message: String
    }
}

// MARK: Function
extension LunarCalendarViewModel {
    func backToCurrentDate() {
        date = Date()
    }

    func setStateShowSetting(_ isShow: Bool) {
        isShowSetting = isShow
    }

    func setStateShowAddMemory(_ isShow: Bool) {
        isShowAddMemory = isShow
    }

    func saveTheDayToFirestore() {
        if titleMemory.isEmpty && location.isEmpty {
            self.floatToastInfo = InformFloatToast(
                title: "Please fill info!",
                message: "Please fill your infomation"
            )
            isShowAddMemory = false
            return
        }
        DispatchQueue.main.async {
            if let image = self.userData.image {
                let fileDirectory = "Memory/" + "\(self.location)_\(UUID().uuidString)" + ".jpg"
                FileStorage.uploadImage(image, directory: fileDirectory) { documentLink in
                    self.memory = OnThisDayModel(
                        id: UUID().uuidString, title: self.titleMemory, location: self.location,
                        time: self.travelOnTime, imageLink: documentLink ?? .empty)
                    self.addMemoryToFirebase()
                }
            } else {
                self.memory = OnThisDayModel(
                    id: UUID().uuidString, title: self.titleMemory, location: self.location, time: self.travelOnTime,
                    imageLink: .empty)
                self.addMemoryToFirebase()
            }
        }

        isShowAddMemory = false
    }

    func addMemoryToFirebase() {
        FStorage.shared
            .firebaseReference(.memory)
            .document(self.memory.id)
            .setData(
                OnThisDateMapper.mapMemoryToFirebase(memory)
            ) { error in
                if error == nil {
                    self.floatToastInfo = InformFloatToast(
                        title: .empty,
                        message: "Upload to Firebase Sucessfully"
                    )
                } else {
                    self.floatToastInfo = InformFloatToast(
                        title: "Error!",
                        message: error?.localizedDescription ?? .empty
                    )
                }
                self.showingToastInform = true
            }
    }
}
