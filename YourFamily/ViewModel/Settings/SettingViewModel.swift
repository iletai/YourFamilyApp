//
//  File.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/7/22.
//

import CVCalendar
import Foundation

final class SettingViewModel: ObservableObject {
    @Published var isShowLunarDate = SettingManager.isShowLunarDate
    @Published var isShowDateOut = SettingManager.isShowDateOut
    @Published var displayMode = CalendarMode(rawValue: SettingManager.displayMode) ?? .monthView
    @Published var dayStartWeek = Weekday(rawValue: SettingManager.startDayInWeek) ?? .monday

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
    func setDayStartWeek(value: Int) {
        dayStartWeek = Weekday(rawValue: value) ?? .monday
        SettingManager.startDayInWeek = value
        CalendarManager.shared.calendarView.contentController.refreshPresentedMonth()
        CalendarManager.shared.calendarMenuView.commitMenuViewUpdate()
    }

    func setDisplayMode(value: Int) {
        return
        displayMode = CalendarMode(rawValue: value) ?? .monthView
        SettingManager.displayMode = value
        CalendarManager.shared.calendarView.changeModeBySetting(mode: value)
    }

    func setLunarDate(_ show: Bool) {
        isShowLunarDate = show
        SettingManager.isShowLunarDate = show
        CalendarManager.shared.calendarView.refeshCalendarMonthView()
    }

    func setDateOutEnable(_ show: Bool) {
        isShowDateOut = show
        SettingManager.isShowDateOut = show
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
