//
//  MenuViewProfile.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/26/22.
//

import SwiftUI
import SwiftUICommon

struct MenuViewProfile: View {
    @StateObject var viewModel: ProfileViewModel
    @State private var tabBar: UITabBar! = nil

    // swiftlint:disable trailing_closure
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                VStack(spacing: 32) {
                    HStack {
                        Image(uiImage: viewModel.userData.image ?? UIImage())
                            .resizable(resizingMode: .stretch)
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 48, height: 48)
                        Spacer()
                    }
                    HStack {
                        Text("Hello, \(viewModel.currentProfile.nickname)")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    HStack {
                        Button {
                        } label: {
                            HStack {
                                Image(systemName: "hammer")
                                    .padding(8)
                                    .background(
                                        Color.c745CF1
                                            .opacity(0.3)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    )
                                Text("Edit Profile")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .fontWeight(.bold)
                            }
                        }
                        Spacer()
                    }
                    HStack {
                        Button {
                        } label: {
                            HStack {
                                Image(systemName: "timelapse")
                                    .padding(8)
                                    .background(
                                        Color.c745CF1
                                            .opacity(0.3)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    )
                                Text("Setting")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .fontWeight(.bold)
                            }
                        }
                        Spacer()
                    }
                    HStack {
                        Button {
                        } label: {
                            HStack {
                                Image(systemName: "person.crop.circle.badge.questionmark")
                                    .padding(8)
                                    .background(
                                        Color.c745CF1
                                            .opacity(0.3)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    )
                                Text("Support")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                            }
                        }
                        Spacer()
                    }
                }
                .padding()
                Spacer()
                HStack {
                    Button {
                        viewModel.showActionSheetSignOut()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "pip.exit")
                            Text("Sign Out")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                        }
                    }
                    Spacer()
                    Button {
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "key.viewfinder")
                            Text("Close")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                        }
                    }
                    Spacer()
                    Button {
                        viewModel.backToHome()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "house")
                            Text("Home")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                        }
                    }
                }
                .padding()
                .overlay(
                    alignment: .top,
                    content: {
                        Rectangle()
                            .frame(height: 1)
                    }
                )
                .widthInfinity()
            }
            .foregroundColor(.black)
        }
        .background(Color.white)
        .widthInfinity()
    }
}

struct MenuViewProfile_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            MenuViewProfile(viewModel: ProfileViewModel())
                .frame(width: UIScreen.main.bounds.width - 64, alignment: .leading)
            Spacer()
        }
        .background(Color.black)
    }
}
