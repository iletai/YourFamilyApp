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
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .shadow(color: .blue, radius: 1, x: 0, y: 2)
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
        let calendarMenu = CVCalendarMenuView()
        calendarMenu.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        calendarMenu.menuViewDelegate = context.coordinator
        calendarMenu.setupAppearance()
        calendarMenu.commitMenuViewUpdate()
        return calendarMenu
    }

    func updateUIView(_ view: CVCalendarMenuView, context: Context) {
        view.setupAppearance()
        view.commitMenuViewUpdate()
    }
}

struct DateInWeekHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DateInWeekHeaderView(date: .constant(Date()))
    }
}
