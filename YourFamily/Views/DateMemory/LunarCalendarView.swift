//
//  LunarCalendarView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import SwiftUI

struct LunarCalendarView: View {
    @State private var currentDate = Date()
    var body: some View {
        ZStack(alignment: .top) {
            Color.gray.opacity(0.1)
            VStack {
                VStack(spacing: 0) {
                    DateInWeekHeaderView()
                    CalendarBodyView(date: $currentDate)
                }
                .padding(8)
                .background(
                    Color.white
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20)
                        )
                        .shadow(color: .gray, radius: 4)
                )
                Spacer()
            }
            .padding()
        }
        .padding(.horizontal, 8)
    }
}

struct LunarCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        LunarCalendarView()
    }
}
