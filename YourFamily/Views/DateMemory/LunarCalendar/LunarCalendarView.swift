//
//  LunarCalendarView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import SwiftUI

struct LunarCalendarView: View {
    @ObservedObject var viewModel = LunarCalendarViewModel()
    @StateObject var settingModel = SettingViewModel()
    var body: some View {
        ZStack(alignment: .top) {
            Color.gray.opacity(0.1)
            VStack {
                VStack(spacing: .zero) {
                    makeHeaderView()
                    DateInWeekHeaderView(date: $viewModel.date)
                    CalendarBodyView(date: $viewModel.date)
                }
                .padding(8)
                .background(
                    Color.white
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20)
                        )
                        .shadow(color: .gray, radius: 4)
                )
                .padding(.bottom, 16)
                makeDateRegionView()
                Spacer()
            }
            .padding()
        }
        .padding(.horizontal, 8)
        .sheet(isPresented: $viewModel.isShowSetting) {
            SettingLunarCalendarView(viewModel: settingModel)
        }
        .onAppear {
            CalendarManager.shared.calendarView.appearance.setupAppearance()
        }
    }

    func makeDateRegionView() -> some View {
        VStack {
            HStack(spacing: .zero) {
                Image(systemName: "sun.max")
                Text("Hôm nay: " + Date().toFullDateString)
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
                    .padding()
                Spacer()
                Button {
                    withAnimation(.linear) {
                        viewModel.backToCurrentDate()
                    }
                } label: {
                    Image(systemName: "return")
                        .renderingMode(.template)
                        .overlay(
                            Color.gray.opacity(0.2)
                                .clipShape(Circle())
                                .frame(width: 40, height: 40)
                                .padding()
                                .shadow(color: .blue, radius: 2, x: 0, y: 2)
                        )
                }

            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
        }
        .background(
            Color.white
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )
                .shadow(color: .gray, radius: 4)
        )
    }

    func makeHeaderView() -> some View {
        HStack {
            DatePicker(
                selection: $viewModel.date,
                displayedComponents: .date
            ) {
            }
            .labelsHidden()
            .frame(maxWidth: 120, alignment: .leading)
            Spacer()
            Button {
                viewModel.setStateShowSetting(true)
            } label: {
                Image(systemName: "gearshape.fill")
            }

        }
        .padding(8)
    }
}

struct LunarCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        LunarCalendarView()
    }
}
