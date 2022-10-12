//
//  MenuViewProfile.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/26/22.
//

import SwiftUI

struct MenuViewProfile: View {
    @StateObject var viewModel: ProfileViewModel
    @State private var tabBar: UITabBar! = nil

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                VStack(spacing: 16) {
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
                            .font(.system(size: 20))
                        Spacer()
                    }
                    HStack {
                        Button {
                        } label: {
                            Text("Edit Profile")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                    HStack {
                        Button {
                        } label: {
                            Text("Setting")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                    HStack {
                        Button {
                        } label: {
                            Text("Support")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
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
                        Text("SignOut")
                    }
                    Button {
                    } label: {
                        Text("Close")
                    }

                    Button {
                        viewModel.backToHome()
                    } label: {
                        Text("Home")
                    }
                    Spacer()
                }
                .padding()
                .background(Color.cF18A5C.ignoresSafeArea())
            }
            .foregroundColor(.white)
        }
        .background(
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
        )
        .frame(maxWidth: .infinity)
    }
}

struct MenuViewProfile_Previews: PreviewProvider {
    static var previews: some View {
        MenuViewProfile(viewModel: ProfileViewModel())
    }
}
