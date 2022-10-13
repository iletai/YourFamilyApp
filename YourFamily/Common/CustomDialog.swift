//
//  CustomDialog.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/13/22.
//

import SwiftUI

struct CustomDialog<DialogContent: View>: ViewModifier {
    @Binding var isShowing: Bool  // set this to show/hide the dialog
    let dialogContent: DialogContent

    init(
        isShowing: Binding<Bool>,
        @ViewBuilder dialogContent: () -> DialogContent
    ) {
        _isShowing = isShowing
        self.dialogContent = dialogContent()
    }

    func body(content: Content) -> some View {
        // wrap the view being modified in a ZStack and render dialog on top of it
        ZStack {
            content
            if isShowing {
                ZStack {
                    dialogContent
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.white))
                }.padding(40)
            }
        }
    }
}
