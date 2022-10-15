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

    init(date: Date) {
        self.date = date
        self.fetchMemoryInThisDate(date)
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
    func fetchMemoryInThisDate(_ date: Date) {
        FStorage.shared.firebaseReference(.memory).getDocuments { snap, error in
            guard let snap = snap else { return }
            if !snap.isEmpty {
                let memorys = OnThisDateMapper.onThisDateFromDictionary(snap)
                self.onThisDateModel = memorys.filter({ model in
                    model.time.compare(toDate: date, granularity: .day) == .orderedSame
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
