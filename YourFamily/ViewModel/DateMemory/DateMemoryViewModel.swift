//
//  DateMemoryViewModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/29/22.
//

import Foundation
import Parchment
import SwiftUI

final class DateMemoryViewModel: ObservableObject {
    @Published var weekdayLabelText = String.empty
    @Published var weekdayLabelTextColor = Color.blue
    @Published var dateLabelText = String.empty
    @Published var dateLabelBackgroundColor = Color.clear
    @Published var tabPageIndex = TabPage.calendar
    @Published var tabPageItem = TabPage.allCases
    @Published var tabPageSelected = 0

    init() {
    }
}

// MARK: - Enum
extension DateMemoryViewModel {
    enum TabPage: Hashable, CaseIterable, Identifiable {
        var id: Self {
            self
        }

        case memory
        case calendar
        case note
        case tracking

        var titleText: String {
            switch self {
            case .memory:
                return "Memory"
            case .calendar:
                return "Calendar"
            case .note:
                return "Notes"
            case .tracking:
                return "Track"
            }
        }

        var image: String {
            switch self {
            case .memory:
                return "timer.square"
            case .calendar:
                return "calendar"
            case .note:
                return "highlighter"
            case .tracking:
                return "filemenu.and.selection"
            }
        }
    }
}

// MARK: - Function
extension DateMemoryViewModel {
    func getCurrentDate() -> Date {
        return Date()
    }
}
