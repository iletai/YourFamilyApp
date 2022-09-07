//
//  CalendarManager.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import Foundation
import SwiftDate
import CVCalendar
import CoreGraphics

public class CalendarManager {
    private init() {
        calendar = Calendar.gregorian
        calendar.locale = Locales.vietnamese.toLocale()

        calendarView = CVCalendarView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: CalendarConfig.calendarMonthSize.width,
                height: CalendarConfig.calendarMonthSize.height
            )
        )
    }

    private(set) var calendar: Calendar
    private(set) var calendarView: CVCalendarView
    static let shared = CalendarManager()
}

extension CVCalendarView {
    func refeshCalendarMonthView() {
        contentController.refreshPresentedMonth()
    }

    func changeModeBySetting(mode: Int) {
        changeMode(CalendarMode(rawValue: mode) ?? .monthView)
    }
}