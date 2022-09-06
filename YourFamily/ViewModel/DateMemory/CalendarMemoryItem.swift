//
//  CalendarMemoryItem.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/29/22.
//

import Parchment
import Foundation

struct CalendarMemoryItem: PagingItem, Hashable, Comparable {
    static func < (lhs: CalendarMemoryItem, rhs: CalendarMemoryItem) -> Bool {
        lhs.date < rhs.date
    }

    let date: Date
    let dateText: String
    let weekdayText: String

    init(_ date: Date) {
        self.date = date
        dateText = date.toDateString
        weekdayText = date.toDayString
    }
}
