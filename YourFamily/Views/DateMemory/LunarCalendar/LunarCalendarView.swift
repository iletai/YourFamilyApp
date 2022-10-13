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
                        .shadow(color: .gray, radius: 4)
                )
                .padding(.bottom, 16)
                makeDateRegionView()
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.linear) {
                            viewModel.setStateShowAddMemory(true)
                        }
                    } label: {
                        Image(systemName: "plus.rectangle.on.rectangle")
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
            isPresented: $viewModel.isShowAddMemory, type: .default, closeOnTap: false,
            closeOnTapOutside: true,
            backgroundColor: .gray.opacity(0.4),
            view: {
                OnThisDateView(memoryModel: viewModel)
                    .padding()
            }
        )
        .popup(
            isPresented: $viewModel.showingToastInform, type: .floater(), position: .bottom,
            animation: .spring(), autohideIn: 2
        ) {
            makeFloatToastMessage()
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
