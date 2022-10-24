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
            ScrollView {
                LazyVStack {
                    if viewModel.onThisDateModel.isEmpty {
                        ZStack {
                            Color.gray.opacity(0.3).scaledToFill()
                            Image(systemName: "photo")
                        }
                        .overlay(alignment: .bottom) {
                            Text("No Data To Show")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .padding()
                        }
                    } else {
                        ForEach(viewModel.onThisDateModel, id: \.time) { item in
                            OnThisDayCardView(viewModel: item)
                                .id(UUID())
                        }
                    }
                }
            }

        }
        .padding()
    }
}

struct MemoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryCardView(todayItemDate: CalendarMemoryItem(Date()))
    }
}
