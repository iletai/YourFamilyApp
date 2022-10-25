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
    @Published var billAmout = Double.zero
    @Published var billCashIn = false

    var menuBudget = BudgeMenuViewModel.QuickSelectionType.allCases
    var bugdetDefine = [50.0, 100.0, 200.0, 500.0, 1000.0]

    init() {
    }
}

// MARK: - Function
extension BudgeMenuViewModel {
    func setBillCost(_ value: Double) {
        billAmout = value
    }
}

extension BudgeMenuViewModel {
    enum QuickSelectionType: CaseIterable {
        case love
        case food
        case drink
        case move
        case events

        static var allCases: [BudgeMenuViewModel.QuickSelectionType] {
            return [.love, .food, .drink, .move, .events]
        }

        var titleName: String {
            switch self {
            case .love:
                return "Send Gift"
            case .drink:
                return "Drink Milk Tea"
            case .events:
                return "Join Events"
            case .food:
                return "Food"
            case .move:
                return "Travel"
            }
        }

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
