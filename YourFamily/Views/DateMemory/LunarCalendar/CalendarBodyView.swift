//
//  CalendarBodyView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import CVCalendar
import Foundation
import SwiftUI
import UIKit

struct CalendarBodyView: View {
    @Binding var date: Date
    init(date: Binding<Date>) {
        _date = date
    }

    var body: some View {
        ZStack(alignment: .top) {
            CalendarBodyChildView(date: $date)
        }
        .frame(
            width: CalendarConfig.calendarMonthSize.width,
            height: CVCalendar.CalendarMode(rawValue: LunarSettingManager.displayMode) == .monthView
            ? CalendarConfig.calendarMonthSize.height
            : CalendarConfig.calendarWeekSize.height
        )
    }
}

extension CalendarBodyView {
    struct CalendarBodyChildView: UIViewRepresentable {
        @Binding var date: Date

        init(date: Binding<Date>) {
            _date = date
        }

        func makeUIView(context: Context) -> CVCalendarView {
            CalendarManager.shared.calendarView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            CalendarManager.shared.calendarView.calendarDelegate = context.coordinator as AnyObject
            CalendarManager.shared.calendarView.animatorDelegate = context.coordinator as AnyObject
            CalendarManager.shared.calendarView.calendarAppearanceDelegate = context.coordinator as AnyObject
            CalendarManager.shared.calendarView.commitCalendarViewUpdate()
            return CalendarManager.shared.calendarView
        }

        func updateUIView(_ uiView: CVCalendarView, context: Context) {
            uiView.toggleViewWithDate(self.date)
            uiView.commitCalendarViewUpdate()
        }

        func makeCoordinator() -> CalendarCVCCoordinator {
            CalendarCVCCoordinator(date: $date)
        }
    }

    class CalendarCVCCoordinator: CVCalendarViewDelegate, CVCalendarViewAppearanceDelegate {
        @Binding var date: Date

        init(date: Binding<Date>) {
            _date = date
        }
        func presentationMode() -> CalendarMode {
            CalendarMode(rawValue: LunarSettingManager.displayMode) ?? .monthView
        }

        func calendar() -> Calendar? {
            CalendarManager.shared.calendar
        }

        func firstWeekday() -> Weekday {
            Weekday(rawValue: LunarSettingManager.startDayInWeek) ?? .monday
        }

        func supplementaryView(shouldDisplayOnDayView _: DayView) -> Bool {
            LunarSettingManager.isShowLunarDate
        }

        func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
            LunarSettingManager.isShowLunarDate ? LunarDateView().makeConfigDateUIView(dayView) ?? UIView() : UIView()
        }

        func shouldAnimateResizing() -> Bool {
            true
        }

        func shouldShowWeekdaysOut() -> Bool {
            LunarSettingManager.isShowDateOut
        }

        func didShowNextMonthView(_ date: Date) {
            self.date = date
        }

        func didShowPreviousMonthView(_ date: Date) {
            self.date = date
        }
    }
}
