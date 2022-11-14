//
//  LunarDateView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import CVCalendar
import Foundation
import UIKit

class LunarDateView: UIStackView {
    func makeConfigDateUIView(_ dayView: DayView) -> UIView? {
        guard let date = dayView.date.convertedDate() else { return nil }
        let lunarDate = DateFormatter.toLunarDateString(forDate: date, format: "dd")
        let label = UILabel(
            frame: CGRect(
                x: dayView.frame.origin.x,
                y: dayView.frame.size.height * 0.7,
                width: dayView.frame.size.width,
                height: 10
            )
        )
        label.font = .systemFont(ofSize: 10)
        label.text = lunarDate
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }
}
