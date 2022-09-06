//
//  DateInWeekHeaderView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import CVCalendar
import SwiftUI

struct DateInWeekHeaderView: View {
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                HeaderWeekCalendar()
                Spacer()
            }
            .background(
                Color.gray
                    .opacity(0.1)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
        }
        .frame(width: CalendarConfig.calendarMonthSize.width, height: 40)
    }
}

struct HeaderWeekCalendar: UIViewRepresentable {
    func makeCoordinator() -> CVCalendarMenuCoordinartor {
        CVCalendarMenuCoordinartor()
    }

    func makeUIView(context: Context) -> CVCalendarMenuView {
        let view = CVCalendarMenuView(
            frame: CGRect(
                x: 0, y: 0,
                width: CalendarConfig.calendarMonthSize.width,
                height: CalendarConfig.calendarHeaderHeight
            )
        )
        view.calendar = CalendarManager.shared.calendar
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ view: CVCalendarMenuView, context: Context) {
    }
}

class CVCalendarMenuCoordinartor: NSObject, CVCalendarMenuViewDelegate {
    func firstWeekday() -> Weekday {
        .monday
    }
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        if weekday == .sunday {
            return .red
        }
        return .black
    }
    func dayOfWeekBackGroundColor(by weekday: Weekday) -> UIColor {
        .clear
    }

    func dayOfWeekTextUppercase() -> Bool {
        true
    }

}

struct DateInWeekHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DateInWeekHeaderView()
    }
}
