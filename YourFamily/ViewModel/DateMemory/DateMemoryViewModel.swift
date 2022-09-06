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
    @Published var itemsPage = [
        PagingIndexItem(index: 0, title: "Calendar"),
        PagingIndexItem(index: 1, title: "Memories"),
    ]

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

        var titleText: String {
            switch self {
            case .memory:
                return "Memory"
            case .calendar:
                return "Calendar"
            case .note:
                return "Notes"
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
