//
//  CalendarCoordinator.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/16/22.
//

import CVCalendar
import SwiftUI

final class CalendarCoordinator: NSObject,
    CVCalendarViewDelegate,
    CVCalendarViewAppearanceDelegate,
    CVCalendarMenuViewDelegate {
    @Binding var date: Date
    var calendarView = CalendarManager.shared.calendarView
    init(date: Binding<Date>) {
        _date = date
    }

    func firstWeekday() -> Weekday {
        Weekday(rawValue: SettingManager.startDayInWeek) ?? .monday
    }

    func dayLabelFont(by _: Weekday, status _: CVStatus, present _: CVPresent) -> UIFont {
        return .boldSystemFont(ofSize: 12)
    }

    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        if weekday == .sunday || weekday == .saturday {
            return .red
        }
        return .black
    }

    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        return UIColor(Color.cB7B7E5)
    }

    func dayLabelWeekdayInTextColor() -> UIColor {
        return UIColor(Color.red)
    }

    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .selected, _),
            (_, .highlighted, _): return .white
        case (.sunday, .out, _): return .red
        case (.sunday, _, _): return .red
        case (_, .in, _): return .black
        default: return UIColor.gray.withAlphaComponent(0.5)
        }
    }

    func dayLabelPresentWeekdayTextColor() -> UIColor {
        return UIColor(Color.c949494)
    }

    func dayLabelPresentWeekdaySelectedTextColor() -> UIColor {
        return .red
    }
    func dayOfWeekFont() -> UIFont { .boldSystemFont(ofSize: 12) }

    func dayOfWeekBackGroundColor(by weekday: Weekday) -> UIColor {
        .clear
    }

    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.frame, shape: CVShape.circle)
        circleView.fillColor = UIColor(Color.c5CCBF1).withAlphaComponent(0.3)
        return circleView
    }

    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        dayView.isCurrentDay
    }

    func dayOfWeekTextUppercase() -> Bool {
        true
    }

    func dayLabelWeekdayDisabledColor() -> UIColor { .gray }

    func dayLabelPresentWeekdayInitallyBold() -> Bool { true }

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
