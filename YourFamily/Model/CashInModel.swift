//
//  CashInModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/17/22.
//

import Foundation
import SwiftDate

struct CashInModel {
    let id: String
    let cost: Double
    let isCashIn: Bool
    let title: String
    let dayInWeek: WeekDay

    static var dummyCashInModel: CashInModel {
        return CashInModel(id: UUID().uuidString, cost: .zero, isCashIn: false, title: .empty, dayInWeek: .monday)
    }
}
