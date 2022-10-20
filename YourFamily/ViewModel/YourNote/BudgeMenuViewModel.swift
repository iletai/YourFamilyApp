//
//  BudgeMenuViewModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/19/22.
//

import Foundation
import SwiftDate

final class BudgeMenuViewModel: ObservableObject {
    @Published var budgetPayment = [CashInModel.dummyCashInModel]
    @Published var billTitle = String.empty
    @Published var billDate = Date()
    @Published var billAmout = String.empty

    init() {
    }
}

extension BudgeMenuViewModel {
    enum QuickSelectionType: CaseIterable {
        case love
        case food
        case drink
        case move
        case events

        var imageName: String {
            switch self {
            case .love:
                return "heart"
            case .drink:
                return "drink-tea"
            case .events:
                return "mail-send"
            case .food:
                return "cog"
            case .move:
                return "bike-city"
            }
        }
    }
}
