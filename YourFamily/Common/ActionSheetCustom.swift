//
//  ActionSheetCustom.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/19/22.
//

import SwiftUI

struct ActionSheetCustom<Content: View>: View {
    let content: Content
    let topPadding: CGFloat
    let fixedHeight: Bool
    let bgColor: Color

    init(
        @ViewBuilder content: () -> Content,
        topPadding: CGFloat = 100,
        fixedHeight: Bool = false,
        bgColor: Color = .white
    ) {
        self.content = content()
        self.topPadding = topPadding
        self.fixedHeight = fixedHeight
        self.bgColor = bgColor
    }

    // swiftlint:disable trailing_closure
    var body: some View {
        ZStack {
            bgColor.cornerRadius(40, corners: [.topLeft, .topRight])
            VStack {
                Color.black
                    .opacity(0.2)
                    .frame(width: 40, height: 6)
                    .clipShape(Capsule())
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                content
                    .padding(.bottom, 32)
                    .doIf(fixedHeight) {
                        $0.frame(height: UIScreen.main.bounds.height - topPadding)
                    }
                    .doIf(
                        !fixedHeight,
                        apply: {
                            $0.frame(maxHeight: UIScreen.main.bounds.height - topPadding)
                        }
                    )
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ActionSheetCustom_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetCustom {
            Text("A")
        }
    }
}
