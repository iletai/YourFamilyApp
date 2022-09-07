//
//  LunarCalendarViewModel.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import Foundation
import CoreGraphics
import CVCalendar

final class LunarCalendarViewModel: ObservableObject {
    @Published var date = Date()
    @Published var isShowSetting = false

    init() {
    }
}

// MARK: Function
extension LunarCalendarViewModel {
    func backToCurrentDate() {
        date = Date()
    }

    func setStateShowSetting(_ isShow: Bool) {
        isShowSetting = isShow
    }
}
