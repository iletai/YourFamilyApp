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
                .padding(.bottom, 16)
                makeDateRegionView()
                Spacer()
            }
            .padding()
        }
        .padding(.horizontal, 8)
    }

    func makeDateRegionView() -> some View {
        VStack {
            HStack(spacing: 0) {
                Image(systemName: "sun.max")
                Text("Hôm nay: " + currentDate.toFullDateString)
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
                    .padding()
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
        }
        .background(
            Color.white
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )
                .shadow(color: .gray, radius: 4)
        )
    }
}

struct LunarCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        LunarCalendarView()
    }
}
