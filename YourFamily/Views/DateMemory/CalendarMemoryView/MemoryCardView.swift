//
//  MemoryCardView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/16/22.
//

import SwiftUI

struct MemoryCardView: View {
    @StateObject var viewModel: MemoryCardViewModel
    init(todayItemDate: CalendarMemoryItem) {
        _viewModel = .init(wrappedValue: MemoryCardViewModel(date: todayItemDate.date))
    }

    var body: some View {
        ZStack(alignment: .leading) {
            ForEach(viewModel.isToDay, id: \.id) { item in
                ScrollView {
                    LazyVStack {
                        Text(item.location)
                            .overlay(
                                VStack(alignment: .leading, spacing: 0) {
                                    Spacer()
                                    HStack {
                                        Text(item.title)
                                            .font(.system(size: 24))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .frame(alignment: .leading)
                                        Spacer()
                                    }
                                    .padding(.leading, 16)
                                    .padding(.bottom, 16)
                                })
                    }
                }
            }

        }
        .cornerRadius(20)
        .padding()
    }
}

struct MemoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryCardView(todayItemDate: CalendarMemoryItem(Date()))
    }
}
