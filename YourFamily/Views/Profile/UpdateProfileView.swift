//
//  UpdateProfileView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/11/22.
//

import SwiftUI
import SwiftUICommon

struct UpdateProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    var body: some View {
        NavigationView {
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
    }

    func makeHeaderView() -> some View {
        VStack(spacing: 8) {
            Group {
                Image(uiImage: viewModel.userData.image ?? UIImage())
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
                    makePhoneRegion()
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
                    makeRegionEmailAdress()
                    Divider()
                    makeRegionBirthday()
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
                Spacer()
                NavigationLink(
                    destination: EditInfoView(
                        viewModel: self.viewModel) {
                            self.viewModel.updateProfile()
                        }
                ) {
                    Text(viewModel.currentProfile.nickname)
                        .foregroundColor(Color.c949494)
                }

            }
            Spacer()
        }
    }

    func makePhoneRegion() -> some View {
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
            HStack {
                Text("Phone number:")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                Spacer()
                Text(viewModel.currentProfile.phoneNumber)
            }
            Spacer()
        }
    }

    func makeRegionEmailAdress() -> some View {
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
            HStack {
                Text("Email Adress:")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                Spacer()
                Text(viewModel.currentProfile.emailAdress)
                    .font(.system(size: 12))
                    .fontWeight(.thin)
                    .foregroundColor(Color.c949494)
            }
            Spacer()
        }
    }

    func makeRegionBirthday() -> some View {
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
            HStack {
                Text("Date of Birth")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                Spacer()
                Text(viewModel.currentProfile.bithday.toFullDateString)
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
