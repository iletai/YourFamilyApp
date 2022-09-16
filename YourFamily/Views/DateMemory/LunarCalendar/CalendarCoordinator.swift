//
//  CalendarCoordinator.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/16/22.
//

import CVCalendar
import SwiftUI

class CalendarCoordinator: NSObject,
    CVCalendarViewDelegate,
    CVCalendarViewAppearanceDelegate,
    CVCalendarMenuViewDelegate
{
    @Binding var date: Date

    init(date: Binding<Date>) {
        _date = date
    }

    func firstWeekday() -> Weekday {
        Weekday(rawValue: SettingManager.startDayInWeek) ?? .monday
    }

    func dayLabelFont(by _: Weekday, status _: CVStatus, present _: CVPresent) -> UIFont {
        .boldSystemFont(ofSize: 12)
    }

    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        if weekday == .sunday || weekday == .saturday {
            return .red
        }
        return .black
    }

    func dayOfWeekFont() -> UIFont { .boldSystemFont(ofSize: 12) }

    func dayOfWeekBackGroundColor(by weekday: Weekday) -> UIColor {
        .clear
    }

    func dayOfWeekTextUppercase() -> Bool {
        true
    }

    func presentationMode() -> CalendarMode {
        CalendarMode(rawValue: SettingManager.displayMode) ?? .monthView
    }

    func calendar() -> Calendar? {
        CalendarManager.shared.calendar
    }

    func supplementaryView(shouldDisplayOnDayView _: DayView) -> Bool {
        SettingManager.isShowLunarDate
    }

    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        SettingManager.isShowLunarDate
            ? LunarDateView().makeConfigDateUIView(dayView) ?? UIView() : UIView()
    }

    func shouldAnimateResizing() -> Bool {
        true
    }

    func shouldShowWeekdaysOut() -> Bool {
        SettingManager.isShowDateOut
    }

    func didShowNextMonthView(_ date: Date) {
        self.date = date
    }

    func didShowPreviousMonthView(_ date: Date) {
        self.date = date
    }
}
