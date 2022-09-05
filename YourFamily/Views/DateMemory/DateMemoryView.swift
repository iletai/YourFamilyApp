//
//  DateMemory.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/26/22.
//

import SwiftUI

struct DateMemoryView: View {
    @ObservedObject var viewModel = DateMemoryViewModel()

    var body: some View {
        CalendarView(
            contentCalendar: { item in
                Text(item.date.toDayString)
            }, selected: viewModel.getCurrentDate())
    }
}

struct DateMemoryView_Previews: PreviewProvider {
    static var previews: some View {
        DateMemoryView()
    }
}
