//
//  MemoryCardView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/13/22.
//

import Foundation

final class MemoryCardViewModel: ObservableObject {
    @Published var date: Date
    @Published var onThisDateModel: [OnThisDayModel] = []
    @Published var isShowToast = false
    @Published var memoryCardInfo = MemoryCardInfo(title: .empty, message: .empty)
    var isToDay: [OnThisDayModel] = []

    init(date: Date) {
        self.date = date
        self.fetchMemoryInThisDate()
    }
}

// MARK: - Struct
extension MemoryCardViewModel {
    struct MemoryCardInfo {
        let title: String
        let message: String
    }
}

// MARK: - Function
extension MemoryCardViewModel {
    func fetchMemoryInThisDate() {
        FStorage.shared.firebaseReference(.memory).getDocuments { snap, error in
            guard let snap = snap else { return }
            if !snap.isEmpty {
                self.onThisDateModel = OnThisDateMapper.onThisDateFromDictionary(snap)
                self.isToDay = self.onThisDateModel.filter({ model in
                    print(model.time.toDayString + "|" + self.date.toDayString)
                    return model.time.toDayString == self.date.toDayString
                })
            } else {
                if let error = error {
                    self.memoryCardInfo = MemoryCardInfo(title: "Error!", message: error.localizedDescription)
                    self.isShowToast = true
                }
            }
        }
    }
}
