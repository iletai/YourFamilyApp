//
//  CalendarConfig.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import Foundation
import UIKit

struct CalendarConfig {
    static var calendarMonthSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 250)
    }

    static var calendarWeekSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 80)
    }

    static var calendarHeaderHeight: CGFloat {
        return 20
    }
}
