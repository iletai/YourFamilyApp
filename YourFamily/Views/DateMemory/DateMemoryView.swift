//
//  DateMemory.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/26/22.
//

import SwiftUI

struct DateMemoryView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                AppRouterManager.shared.setRouterState(.setting)
            }
    }
}

struct DateMemoryView_Previews: PreviewProvider {
    static var previews: some View {
        DateMemoryView()
    }
}
