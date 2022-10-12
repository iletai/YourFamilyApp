//
//  ViewExtension.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/5/22.
//

import SwiftUI

extension View {
    func debugAction(_ closure: () -> Void) -> Self {
        #if DEBUG
            closure()
        #endif

        return self
    }

    func debugPrint(_ value: Any) -> Self {
        debugAction { print(value) }
    }

    func debugModifier<T: View>(_ modifier: (Self) -> T) -> some View {
        #if DEBUG
            return modifier(self)
        #else
            return self
        #endif
    }

    func debugBorder(_ color: Color = .red, width: CGFloat = 1) -> some View {
        debugModifier {
            $0.border(color, width: width)
        }
    }

    func debugBackground(_ color: Color = .red) -> some View {
        debugModifier {
            $0.background(color)
        }
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }

    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
