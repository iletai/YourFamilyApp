//
//  File.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/7/22.
//

import CVCalendar
import Foundation

final class SettingViewModel: ObservableObject {
    @Published var isShowLunarDate = false
    @Published var isShowDateOut = false
    @Published var displayMode = CalendarMode.monthView
    @Published var dayStartWeek = Weekday.monday

    var dayWeek =
    [Weekday.sunday,
     Weekday.monday,
     Weekday.tuesday,
     Weekday.wednesday,
     Weekday.thursday,
     Weekday.friday,
     Weekday.saturday
    ]

    var calendarMode = [CalendarMode.monthView, CalendarMode.weekView]

    init() {
    }
}

// MARK: Function
extension SettingViewModel {
    func setCalendarMode(isShow: Bool) {
        LunarSettingManager.isShowLunarDate = isShow
    }

    func setDayStartWeek(value: Int) {
        dayStartWeek = Weekday(rawValue: value) ?? .monday
        LunarSettingManager.startDayInWeek = value
        CalendarManager.shared.calendarView.contentController.refreshPresentedMonth()
    }

    func setDisplayMode(value: Int) {
        displayMode = CalendarMode(rawValue: value) ?? .monthView
        LunarSettingManager.displayMode = value
        CalendarManager.shared.calendarView.changeModeBySetting(mode: value)
    }

    func setLunarDate(_ show: Bool) {
        LunarSettingManager.isShowLunarDate = show
        CalendarManager.shared.calendarView.refeshCalendarMonthView()
    }

    func setDateOutEnable(_ show: Bool) {
        LunarSettingManager.isShowDateOut = show
        CalendarManager.shared.calendarView.refeshCalendarMonthView()
    }
}

extension Weekday {
    var stringValue: String {
        switch self {
        case .sunday:
            return "Sun"
        case .monday:
            return "Mon"
        case .tuesday:
            return "Tue"
        case .wednesday:
            return "Wed"
        case .thursday:
            return "Thu"
        case .friday:
            return "Fri"
        case .saturday:
            return "Sat"
        }
    }
}

extension CalendarMode {
    var stringValue: String {
        switch self {
        case .monthView:
            return "Month"
        case .weekView:
            return "Week"
        }
    }
}
