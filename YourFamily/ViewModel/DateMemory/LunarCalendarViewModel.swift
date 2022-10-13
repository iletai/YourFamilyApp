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

    init() {
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
        if let image = userData.image {
            let fileDirectory = "Memory/" + "\(location)_\(FUser.currentId())" + ".jpg"
            FileStorage.uploadImage(image, directory: fileDirectory) { documentLink in
                self.memory = OnThisDayModel(
                    id: FUser.currentId(), title: self.titleMemory, location: self.location,
                    time: self.travelOnTime, imageLink: documentLink ?? .empty)
                FStorage.shared
                    .firebaseReference(.memory)
                    .document(self.memory.id)
                    .setData(
                        OnThisDateMapper.mapMemoryToFirebase(self.memory)
                    ) { error in
                        if error == nil {
                            print("Upload to Firebase Sucessfully")
                        } else {
                            // Show Error
                            print(error?.localizedDescription ?? .empty)
                        }

                    }
            }
        } else {
            memory = OnThisDayModel(
                id: FUser.currentId(), title: titleMemory, location: location, time: travelOnTime,
                imageLink: .empty)
            FStorage.shared
                .firebaseReference(.memory)
                .document(memory.id)
                .setData(
                    OnThisDateMapper.mapMemoryToFirebase(memory)
                ) { error in
                    if error == nil {
                        print("Upload to Firebase Sucessfully")
                    } else {
                        // Show Error
                        print(error?.localizedDescription ?? .empty)
                    }

                }
        }
        isShowAddMemory.toggle()
    }
}
