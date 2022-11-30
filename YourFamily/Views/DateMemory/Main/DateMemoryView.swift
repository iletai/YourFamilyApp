//
//  DateMemory.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/26/22.
//

import Parchment
import SwiftUI

struct DateMemoryView: View {
    @StateObject var viewModel = DateMemoryViewModel()

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    ForEach(viewModel.tabPageItem, id: \.self) { item in
                        tabButton(title: item.titleText, tag: item.id)
                    }
                }
                .padding(.top)
                .font(.headline)
                .background(
                    Color.c5CCBF1
                        .ignoresSafeArea()
                )
                TabView(selection: $viewModel.tabPageIndex) {
                    MemoryCalendarView(
                        contentCalendar: { item in
                            MemoryCardView(todayItemDate: item)
                        }, selected: viewModel.getCurrentDate()
                    )
                    .tag(DateMemoryViewModel.TabPage.memory)
                    LunarCalendarView()
                        .tag(DateMemoryViewModel.TabPage.calendar)
                    YourNoteView()
                        .tag(DateMemoryViewModel.TabPage.note)
                    LunarCalendarView()
                        .tag(DateMemoryViewModel.TabPage.tracking)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
    }

    func tabButton(title: String, tag: DateMemoryViewModel.TabPage) -> some View {
        VStack {
            Button {
                withAnimation { viewModel.tabPageIndex = tag }
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: tag.image)
                    Text(title)
                }
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(viewModel.tabPageIndex == tag ? .primary : .secondary)

            Color(viewModel.tabPageIndex == tag ? .white : .clear)
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
