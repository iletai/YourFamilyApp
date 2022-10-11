//
//  UpdateProfileView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/11/22.
//

import SwiftUI

struct UpdateProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    .c051937,
                    Color(hex: "051937"),
                    Color(hex: "008793"),
                    Color(hex: "00bf72"),
                    .cA8EB12
                ]), startPoint: .bottomLeading, endPoint: .topTrailing
            )
            .opacity(0.5)
            VStack(spacing: .zero) {
                makeHeaderView()
                    .padding(.bottom, 20)
                makeCenterView()
                Spacer()
            }
            .padding(.top, 36)
        }
        .ignoresSafeArea()
    }

    func makeHeaderView() -> some View {
        VStack(spacing: 8) {
            Group {
                Image("dummyAvatar")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 80, height: 80)
                    .padding(8)
            }
            .foregroundColor(.white)

        }
        .frame(maxWidth: .infinity)
    }

    func makeCenterView() -> some View {
        ZStack(alignment: .top) {
            Color.white
                .cornerRadius(45, corners: [.topLeft, .topRight])
            Rectangle()
                .fill(Color.cB7B7E5.opacity(0.2))
                .cornerRadius(45, corners: [.topLeft, .topRight])
            VStack {
                VStack(spacing: 20) {
                    makeRegionMonthSetting()
                    Divider()
                    makeRegionDayStartWeek()
                }
                .padding(.horizontal, 21)
                .padding(.vertical, 24)
                .background(
                    Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 22))
                        .shadow(color: .gray, radius: 4, x: 0, y: 4)
                )
                .frame(maxWidth: .infinity, maxHeight: 150)
                .padding(.top, 20)
                VStack(spacing: 20) {
                    makeRegionShowLunarDay()
                    Divider()
                    makeRegionShowDayOut()
                }
                .padding(.horizontal, 21)
                .padding(.vertical, 24)
                .background(
                    Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 22))
                        .shadow(color: .gray, radius: 4, x: 0, y: 4)
                )
                .frame(maxWidth: .infinity, maxHeight: 150)
                .padding(.top, 20)
            }
            .padding(16)
        }
    }

    func makeRegionMonthSetting() -> some View {
        HStack {
            Color.cC55CF1
                .clipShape(Rectangle())
                .cornerRadius(6)
                .overlay(
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 18, height: 14)
                )
                .frame(width: 30, height: 30)
            HStack {
                Text("Nick name")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                Text(viewModel.currentProfile?.nickname ?? .empty)
                    .font(.system(size: 12))
                    .fontWeight(.thin)
                    .foregroundColor(Color.c949494)
            }
            Spacer()
        }
    }

    func makeRegionDayStartWeek() -> some View {
        HStack {
            Color.c745CF1
                .clipShape(Rectangle())
                .cornerRadius(6)
                .overlay(
                    Image(systemName: "calendar.day.timeline.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 18, height: 14)
                )
                .frame(width: 30, height: 30)
            VStack(alignment: .leading, spacing: 0) {
                Text("Day start week")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                Text("First day of week")
                    .font(.system(size: 12))
                    .fontWeight(.thin)
                    .foregroundColor(Color.c949494)
            }
            Spacer()
        }
    }

    func makeRegionShowLunarDay() -> some View {
        HStack {
            Color.c5CCBF1
                .clipShape(Rectangle())
                .cornerRadius(6)
                .overlay(
                    Image(systemName: "calendar.day.timeline.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 18, height: 14)
                )
                .frame(width: 30, height: 30)
            VStack(alignment: .leading, spacing: 0) {
                Text("Enable Vietnamese Lunar Day")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(maxWidth: .infinity)
                Text("Show Lunar Date")
                    .font(.system(size: 12))
                    .fontWeight(.thin)
                    .foregroundColor(Color.c949494)
            }
            Spacer()
        }
    }

    func makeRegionShowDayOut() -> some View {
        HStack {
            Color.cF18A5C
                .clipShape(Rectangle())
                .cornerRadius(6)
                .overlay(
                    Image(systemName: "calendar.day.timeline.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 18, height: 14)
                )
                .frame(width: 30, height: 30)
            VStack(alignment: .leading, spacing: 0) {
                Text("Show Date Out Of Month")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(maxWidth: .infinity)
                Text("Show date out")
                    .font(.system(size: 12))
                    .fontWeight(.thin)
                    .foregroundColor(Color.c949494)
            }
            Spacer()
        }
    }
}

struct UpdateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView(viewModel: ProfileViewModel())
    }
}
