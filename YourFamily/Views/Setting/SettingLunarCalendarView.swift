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
            Color(Color.backgroundColor)
                .ignoresSafeArea()
                .scaledToFill()
            Text("Setting Lunar Calendar View")
        }
    }
}

struct SettingLunarCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        SettingLunarCalendarView()
    }
}
