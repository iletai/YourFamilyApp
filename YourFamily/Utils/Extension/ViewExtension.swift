//
//  ViewExtension.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/5/22.
//

import MapKit
import SwiftUI

extension View {
    func customDialog<DialogContent: View>(
        isShowing: Binding<Bool>,
        @ViewBuilder dialogContent: @escaping () -> DialogContent
    ) -> some View {
        self.modifier(CustomDialog(isShowing: isShowing, dialogContent: dialogContent))
    }

    @available(iOS 15.0, *)
    func mapItemPicker(
        isPresented: Binding<Bool>,
        onDismiss: ((MKMapItem?) -> Void)? = nil
    ) -> some View {
        MapItemPickerSheet(isPresented: isPresented, onDismiss: onDismiss, content: self)
    }
}

enum ViewExtension {}
