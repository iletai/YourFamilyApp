//
//  DateMemoryViewModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/29/22.
//

import SwiftUI
import Foundation

final class DateMemoryViewModel: ObservableObject {
    @Published var weekdayLabelText = String.empty
    @Published var weekdayLabelTextColor = Color.blue
    @Published var dateLabelText = String.empty
    @Published var dateLabelBackgroundColor = Color.clear

    init() {
    }
}

// MARK: - Function
extension DateMemoryViewModel {
    func getCurrentDate() -> Date {
        return Date()
    }
}
