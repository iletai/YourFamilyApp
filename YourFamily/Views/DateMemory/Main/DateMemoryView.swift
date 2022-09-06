//
//  DateMemory.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/26/22.
//

import Parchment
import SwiftUI

struct DateMemoryView: View {
    @ObservedObject var viewModel = DateMemoryViewModel()

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    ForEach(viewModel.tabPageItem) { item in
                        tabButton(title: item.titleText, tag: item.id)
                    }
                }
                .padding(.top)
                .font(.headline)
                TabView(selection: $viewModel.tabPageIndex) {
                    MemoryCalendarView(
                        contentCalendar: { item in
                            Text(item.date.toDayString)
                        }, selected: viewModel.getCurrentDate()
                    )
                    .tag(DateMemoryViewModel.TabPage.memory)
                    LunarCalendarView()
                        .tag(DateMemoryViewModel.TabPage.calendar)
                    YourNoteView()
                        .tag(DateMemoryViewModel.TabPage.note)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
    }

    func tabButton(title: String, tag: DateMemoryViewModel.TabPage) -> some View {
        VStack {
            Button(title) { withAnimation { viewModel.tabPageIndex = tag } }
                .frame(maxWidth: .infinity)
                .foregroundColor(viewModel.tabPageIndex == tag ? .primary : .secondary)

            Color(viewModel.tabPageIndex == tag ? .blue : .clear)
                .frame(height: 4)
                .padding(.horizontal)
        }
    }
}

struct DateMemoryView_Previews: PreviewProvider {
    static var previews: some View {
        DateMemoryView()
    }
}
