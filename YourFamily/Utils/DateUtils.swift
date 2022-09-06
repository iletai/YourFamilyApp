//
//  DateUtils.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/5/22.
//

import Foundation
import SwiftDate

struct DateUtils {
    static func getDayDiff(_ date: Date, _ target: Date = Date()) -> Int? {
        let tempCalendar = Calendar.gregorian
        let currentYear = tempCalendar.component(.year, from: date)
        let currentMonth = tempCalendar.component(.month, from: date)
        let currentDay = tempCalendar.component(.day, from: date)
        let nowDate = target
        let nowYear = tempCalendar.component(.year, from: nowDate)
        let nowMonth = tempCalendar.component(.month, from: nowDate)
        let nowDay = tempCalendar.component(.day, from: nowDate)

        if let current = tempCalendar.date(
            from: DateComponents(
                era: 1,
                year: currentYear,
                month: currentMonth,
                day: currentDay,
                hour: .zero,
                minute: .zero,
                second: .zero,
                nanosecond: .zero
            )
        ),
            let now = tempCalendar.date(
                from: DateComponents(
                    era: 1,
                    year: nowYear,
                    month: nowMonth,
                    day: nowDay,
                    hour: .zero,
                    minute: .zero,
                    second: .zero,
                    nanosecond: .zero
                )
            ) {
            return Int(current.timeIntervalSince1970 - now.timeIntervalSince1970) / 24 / 60 / 60
        }
        return nil
    }

    static func addingDay(_ date: Date, day: TimeInterval) -> Date {
        return date.addingTimeInterval((60 * 60 * 24) * day)
    }
}

extension Calendar {
    static var gregorian: Calendar {
        Calendar(identifier: .gregorian)
    }
}
