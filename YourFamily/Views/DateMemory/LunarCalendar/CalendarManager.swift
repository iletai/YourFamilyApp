//
//  CalendarManager.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import Foundation
import SwiftDate

public class CalendarManager {
    private init() {
        calendar = Calendar.gregorian
        calendar.locale = Locales.vietnamese.toLocale()
    }
    public private(set) var calendar: Calendar
    static let shared = CalendarManager()
}
