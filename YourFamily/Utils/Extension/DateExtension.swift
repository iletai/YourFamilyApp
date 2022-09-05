//
//  DateExtension.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/29/22.
//

import Foundation

extension Date {
    func year(from: Date) -> Int {
        return Calendar.current.component(.year, from: from)
    }

    var toLunarMonthDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .chinese)
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: date)
    }

    var toLunarDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .chinese)
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }

    var startDate: Date {
        dateAtStartOf(.day)
    }

    var endDate: Date {
        dateAtEndOf(.day)
    }

    var toHourAndMinuteString: String {
        DateFormatter.format(self, format: "HH:mm")
    }

    var toShortDateString: String {
        DateFormatter.format(self, format: "d")
    }

    var toDateString: String {
        DateFormatter.format(self, format: "d")
    }

    var toDateAndMonthString: String {
        DateFormatter.format(self, format: "MMM d")
    }

    var toDayString: String {
        DateFormatter.format(self, format: "E")
    }

    var toMonthString: String {
        DateFormatter.format(self, format: "MMMM")
    }

    var toMonthAndYearString: String {
        DateFormatter.format(self, format: "MMMM yyyy")
    }

    var toYearString: String {
        DateFormatter.format(self, format: "yyyy")
    }

    var toFullDateString: String {
        DateFormatter.format(self, format: "EEEE, MMM d, yyyy")
    }

    var toFullDayString: String {
        DateFormatter.format(self, format: "EEEE")
    }

    var toDayAndDateString: String {
        DateFormatter.format(self, format: "EEEE d")
    }

    var midnight: Date {
        Calendar.current.startOfDay(for: self)
    }

    func asStringWithTemplate(_ format: String) -> String {
        DateFormatter.format(self, format: format)
    }

    var nextHour: Date {
        dateByAdding(1, .hour).dateAtStartOf(.hour).date
    }

    var toFullEventDate: String {
        DateFormatter.format(self, format: "EEEE, MMM d, yyyy. HH:mm")
    }
}
