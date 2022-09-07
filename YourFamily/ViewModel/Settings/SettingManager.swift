//
//  LunarSettingManager.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/7/22.
//

import CVCalendar
import SwiftUI

struct SettingManager {
    @UserDefault(UserDefaultKey.calendarViewMode, defaultValue: CVCalendarViewPresentationMode.monthView.rawValue)
    static var displayMode: Int

    @UserDefault(UserDefaultKey.showLunar, defaultValue: true)
    static var isShowLunarDate: Bool

    @UserDefault(UserDefaultKey.showDateOut, defaultValue: true)
    static var isShowDateOut: Bool

    @UserDefault(UserDefaultKey.dateStartOfWeek, defaultValue: Weekday.monday.rawValue)
    static var startDayInWeek: Int

    @UserDefault(UserDefaultKey.loggedApp, defaultValue: false)
    static var loggedApp: Bool

    @UserDefault(UserDefaultKey.emailLoggedIn, defaultValue: "")
    static var emailLoggedIn: String
}
