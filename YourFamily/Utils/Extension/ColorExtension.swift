//
//  ColorExtension.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/26/22.
//

import SwiftUI

extension Color {
    static let backgroundColor = Color.gray
    static let cB7B7E5 = Color(hex: "B7B7E5")
    static let cC55CF1 = Color(hex: "C55CF1")
    static let c949494 = Color(hex: "949494")
    static let c232020 = Color(hex: "232020")
    static let c745CF1 = Color(hex: "745CF1")
    static let c5CCBF1 = Color(hex: "5CCBF1")
    static let cF18A5C = Color(hex: "F18A5C")
    static let c051937 = Color(hex: "051937")
    static let cA8EB12 = Color(hex: "A8EB12")

    /// Text Color: 595085
    static let c595085 = Color(hex: "595085")

    // swiftlint:disable identifier_name
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a: UInt64
        let r: UInt64
        let g: UInt64
        let b: UInt64
        switch hex.count {
        case 3:  // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:  // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:  // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
