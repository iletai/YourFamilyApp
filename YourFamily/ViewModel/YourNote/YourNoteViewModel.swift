//
//  File.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/17/22.
//

import Foundation

final class YourNoteViewModel: ObservableObject {
    @Published var dataInput = [CashInModel(id: UUID().uuidString, cost: 4.0, isCashIn: true, title: "Mua Shoes", dayInWeek: .friday),
                                CashInModel(id: UUID().uuidString, cost: 5.0, isCashIn: true, title: "Mua Shoes", dayInWeek: .friday),
                                CashInModel(id: UUID().uuidString, cost: 7.0, isCashIn: true, title: "Mua Shoes", dayInWeek: .friday),
                                CashInModel(id: UUID().uuidString, cost: 2.0, isCashIn: false, title: "Mua Shoes", dayInWeek: .friday),
                                CashInModel(id: UUID().uuidString, cost: 30.0, isCashIn: true, title: "Mua Shoes", dayInWeek: .friday),
                                CashInModel(id: UUID().uuidString, cost: 40.0, isCashIn: false, title: "Mua Shoes", dayInWeek: .friday),
                                CashInModel(id: UUID().uuidString, cost: 40.0, isCashIn: false, title: "Mua Shoes", dayInWeek: .friday),
                                CashInModel(id: UUID().uuidString, cost: 40.0, isCashIn: false, title: "Mua Shoes", dayInWeek: .friday)
    ]


    init() {
    }
}

// MARK: - Enum
extension YourNoteViewModel {

}

// MARK: - Function
extension YourNoteViewModel {

}
