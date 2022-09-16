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
            height: CVCalendar.CalendarMode(rawValue: SettingManager.displayMode) == .monthView
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
            CalendarManager.shared.calendarView.calendarAppearanceDelegate = context.coordinator as AnyObject
            CalendarManager.shared.calendarView.calendarDelegate = context.coordinator as AnyObject
            CalendarManager.shared.calendarView.animatorDelegate = context.coordinator as AnyObject
            CalendarManager.shared.calendarView.appearance.setupAppearance()
            return CalendarManager.shared.calendarView
        }

        func updateUIView(_ uiView: CVCalendarView, context: Context) {
            uiView.toggleViewWithDate(self.date)
            uiView.appearance.setupAppearance()
            uiView.commitCalendarViewUpdate()
        }

        func makeCoordinator() -> CalendarCoordinator {
            CalendarCoordinator(date: $date)
        }
    }
}
