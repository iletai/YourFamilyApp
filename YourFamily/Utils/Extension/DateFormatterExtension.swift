//
//  DateFormatterExtension.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/29/22.
//

import SwiftDate
import Foundation

extension DateFormatter {
    static func toLunarDateString(forDate: Date, format: String = "MMdd") -> String {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locales.vietnamese.toLocale()
        dateFormat.setLocalizedDateFormatFromTemplate(format)
        dateFormat.calendar = Calendar.init(identifier: .chinese)
        return dateFormat.string(from: forDate)
    }

    static func format(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locales.vietnamese.toLocale()
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: date)
    }
}
