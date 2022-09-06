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
        .frame(width: CalendarConfig.calendarMonthSize.width, height: CalendarConfig.calendarMonthSize.height)
    }
}

extension CalendarBodyView {
    struct CalendarBodyChildView: UIViewRepresentable {
        @Binding var date: Date

        init(date: Binding<Date>) {
            _date = date
        }

        func makeUIView(context: Context) -> CVCalendarView {
            let calendarView = CVCalendarView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: CalendarConfig.calendarMonthSize.width,
                    height: CalendarConfig.calendarMonthSize.height
                )
            )
            calendarView.calendarDelegate = context.coordinator as AnyObject
            calendarView.animatorDelegate = context.coordinator as AnyObject
            calendarView.calendarAppearanceDelegate = context.coordinator as AnyObject
            calendarView.commitCalendarViewUpdate()
            return calendarView
        }

        func updateUIView(_ uiView: CVCalendarView, context: Context) {
            uiView.toggleViewWithDate(self.date)
            uiView.commitCalendarViewUpdate()
        }

        func makeCoordinator() -> CalendarCVCCoordinator {
            CalendarCVCCoordinator()
        }
    }

    class CalendarCVCCoordinator: CVCalendarViewDelegate, CVCalendarViewAppearanceDelegate {
        func presentationMode() -> CalendarMode {
            .monthView
        }

        func firstWeekday() -> Weekday {
            .monday
        }

        func supplementaryView(shouldDisplayOnDayView _: DayView) -> Bool {
            return true
        }

        func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
            return LunarDateView().makeConfigDateUIView(dayView) ?? UIView()
        }
    }
}
