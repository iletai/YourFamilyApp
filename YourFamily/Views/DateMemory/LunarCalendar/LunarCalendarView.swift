//
//  LunarCalendarView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import PopupView
import SwiftUI

struct LunarCalendarView: View {
    @ObservedObject var viewModel = LunarCalendarViewModel()
    @StateObject var settingModel: SettingViewModel
    @Environment(\.presentationMode) private var presentationMode

    init() {
        _settingModel = .init(wrappedValue: SettingViewModel())
    }

    // swiftlint:disable trailing_closure
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
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .gray.opacity(0.3), radius: 2)
                )
                .padding(.bottom, 16)
                makeDateRegionView()
                Spacer()
                Image("calendar_image")
                    .resizable()
                    .scaledToFit()
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.linear) {
                            viewModel.setStateShowAddMemory(true)
                        }
                    } label: {
                        Image("calendar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding()
                            .background(Color.c5CCBF1.clipShape(Circle()))
                    }
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                }
            }
            .padding()
        }
        .environmentObject(settingModel)
        .padding(.horizontal, 8)
        .sheet(isPresented: $viewModel.isShowSetting) {
            SettingLunarCalendarView(viewModel: settingModel)
        }
        .popup(
            isPresented: $viewModel.isShowAddMemory,
            type: .default,
            closeOnTap: false,
            closeOnTapOutside: true,
            backgroundColor: .gray.opacity(0.4),
            view: {
                OnThisDateView(memoryModel: viewModel)
                    .padding()
            }
        )
        .popup(
            isPresented: $viewModel.showingToastInform,
            type: .floater(),
            position: .bottom,
            animation: .spring(),
            autohideIn: 2
        ) {
            makeFloatToastMessage()
        }
    }

    func makeDateRegionView() -> some View {
        VStack {
            HStack(spacing: .zero) {
                Image(systemName: viewModel.date.compare(.isNight) ? "sun.max" : "cloud.moon")
                    .foregroundColor(.yellow)
                Text("Hôm nay: " + viewModel.date.toFullDateString)
                    .fontWeight(.semibold)
                    .font(.system(size: 12))
                    .padding()
                Spacer()
                Button {
                    withAnimation(.linear) {
                        viewModel.backToCurrentDate()
                    }
                } label: {
                    Text("To day")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(
                                    Color.c232020
                                    .opacity(0.3)
                                )
                                .shadow(color: .blue, radius: 1, x: 0, y: 1)
                        )
                }
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
        }
        .background(
            Color.white
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                .shadow(color: .gray, radius: 1)
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
            .frame(maxWidth: 130, alignment: .leading)
            .fixedSize()
            Spacer()
            Button {
                viewModel.setStateShowSetting(true)
            } label: {
                Image("cog")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.bottom, 8)
    }

    func makeFloatToastMessage() -> some View {
        HStack(spacing: 0) {
            Text(viewModel.floatToastInfo.message)
                .font(.system(size: 15))
                .foregroundColor(.black)
            Spacer()
            Image(uiImage: viewModel.userData.image ?? UIImage())
                .frame(width: 32, height: 32)
                .cornerRadius(16)
        }
        .padding(16)
        .background(Color.white.cornerRadius(12))
        .shadowedStyle()
        .padding(.horizontal, 16)
    }
}

struct LunarCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        LunarCalendarView()
    }
}
