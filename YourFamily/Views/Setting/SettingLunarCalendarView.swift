//
//  SettingLunarCalendarView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import SwiftUI

struct SettingLunarCalendarView: View {
    var body: some View {
        ZStack {
            VStack {
                makeHeaderView()
                makeBodyView()
                Spacer()
            }
        }
    }

    func makeHeaderView() -> some View {
        VStack(spacing: 8) {
            Text(Date().toLunarDate)
                .font(.headline)
                .fontWeight(.semibold)
                .padding(8)
                .background(
                    Color.gray
                        .opacity(0.3)
                        .frame(width: 61, height: 61)
                        .clipShape(Circle())
                )
                .padding()
            Text(Date().toFullDateString)
                .font(.system(size: 20))
                .fontWeight(.bold)
        }
    }

    func makeBodyView() -> some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color.cB7B7E5.opacity(0.2))
                .cornerRadius(45, corners: [.topLeft, .topRight])
            VStack(spacing: 20) {
                makeRegionMonthSetting()
                Divider()
                makeRegionMonthSetting()
            }
            .padding(.horizontal, 21)
            .padding(.vertical, 24)
            .background(
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .shadow(color: .gray, radius: 4, x: 0, y: 4)
            )
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: 150)
            .padding(.top, 20)
        }
        .ignoresSafeArea()
    }

    func makeRegionMonthSetting() -> some View {
        HStack {
            Color.cC55CF1
                .clipShape(Rectangle())
                .cornerRadius(6)
                .overlay(
                    Image(systemName: "wifi")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 18, height: 14)
                )
                .frame(width: 30, height: 30)
            VStack(alignment: .leading, spacing: 0) {
                Text("Show month calendar")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                Text("Calendar View Month")
                    .font(.system(size: 12))
                    .fontWeight(.thin)
                    .foregroundColor(Color.c949494)
            }
            Spacer()
            Toggle(isOn: .constant(true)) {
            }
        }
    }
}

struct SettingLunarCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        SettingLunarCalendarView()
    }
}
