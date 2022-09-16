//
//  DateInWeekHeaderView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import CVCalendar
import SwiftUI

struct DateInWeekHeaderView: View {
    @Binding var date: Date
    init(date: Binding<Date>) {
        _date = date
    }
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                HeaderWeekCalendar(date: $date)
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
    @Binding var date: Date
    init(date: Binding<Date>) {
        _date = date
    }

    func makeCoordinator() -> CalendarCoordinator {
        CalendarCoordinator(date: $date)
    }

    func makeUIView(context: Context) -> CVCalendarMenuView {
        CalendarManager.shared.calendarMenuView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        CalendarManager.shared.calendarMenuView.menuViewDelegate = context.coordinator
        CalendarManager.shared.calendarMenuView.setupAppearance()
        CalendarManager.shared.calendarMenuView.commitMenuViewUpdate()
        return CalendarManager.shared.calendarMenuView
    }

    func updateUIView(_ view: CVCalendarMenuView, context: Context) {
        view.commitMenuViewUpdate()
    }
}

struct DateInWeekHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DateInWeekHeaderView(date: .constant(Date()))
    }
}
