//
//  ProfileView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/26/22.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Color.c745CF1
                        .opacity(0.1)
                        .scaledToFill()
                        .ignoresSafeArea()
                    VStack {
                        makeHeaderProfileArea()
                        makeCenterProfileArea()
                        makeCenterProfileArea()
                        makeFamilyOnlineArea()
                        Spacer()
                    }
                    .offset(x: viewModel.showMenuProfile ? geo.size.width - 64 : 0)
                    .padding(.top, 8)
                    .padding(.horizontal, viewModel.showMenuProfile ? 0 : 16)
                    .frame(width: geo.size.width, height: geo.size.height)
                    if viewModel.showMenuProfile {
                        MenuViewProfile(viewModel: viewModel)
                            .frame(width: geo.size.width - 64)
                            .transition(.move(edge: .leading))
                            .zIndex(0)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Profile")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .bold()
                                .foregroundColor(.c595085)
                        }
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged {
                            if $0.translation.width > 100 {
                                withAnimation {
                                    self.viewModel.showMenuProfile = true
                                }
                            }
                        }
                        .onEnded {
                            if $0.translation.width < -100 {
                                withAnimation {
                                    self.viewModel.showMenuProfile = false
                                }
                            }
                        }
                )
                .navigationBarItems(
                    leading:
                        Button(
                            action: {
                                withAnimation {
                                    self.viewModel.showMenuProfile.toggle()
                                }
                            },
                            label: {
                                Image(systemName: "line.3.horizontal")
                                    .renderingMode(.template)
                                    .foregroundColor(.c595085)
                            }),
                    trailing:
                        Button(
                            action: {
                            },
                            label: {
                                Image(systemName: "circle.hexagonpath")
                                    .renderingMode(.template)
                                    .foregroundColor(.c595085)
                            })
                )
                .navigationBarTitleDisplayMode(.inline)
            }
            .actionSheet(isPresented: $viewModel.isShowActionSheet) {
                .init(
                    title: Text("Settings"), message: Text("What do you want to do?"),
                    buttons: [
                        .destructive(
                            Text("Sign Out"),
                            action: {
                                viewModel.signOut()
                            }),
                        .cancel()
                    ])
            }
        }
    }

    func makeCenterProfileArea() -> some View {
        HStack {
            VStack(spacing: 10) {
                HStack {
                    Image(systemName: "person")
                        .frame(width: 16, height: 16)
                    Spacer()
                }

                Text("Astro- psychological report")
                    .fontWeight(.medium)
                    .font(.caption)
                    .frame(width: 113, alignment: .topLeading)

                Text("Some short description of this type of report.")
                    .font(.caption2)
                    .frame(width: 113, alignment: .topLeading)
                    .opacity(0.50)
            }
            .padding(20)
            .frame(width: 153, height: 128)
            .background(Color(red: 0.96, green: 0.96, blue: 0.98))
            .cornerRadius(15)
            .frame(width: 153, height: 128)
            VStack(spacing: 10) {
                HStack {
                    Image(systemName: "person")
                        .frame(width: 16, height: 16)
                    Spacer()
                }

                Text("Astro- psychological report")
                    .fontWeight(.medium)
                    .font(.caption)
                    .frame(width: 113, alignment: .topLeading)

                Text("Some short description of this type of report.")
                    .font(.caption2)
                    .frame(width: 113, alignment: .topLeading)
                    .opacity(0.50)
            }
            .padding(20)
            .frame(width: 153, height: 128)
            .background(Color(hex: "F5F9F9"))
            .cornerRadius(15)
            .frame(width: 153, height: 128)
        }
    }

    // swiftlint:disable function_body_length
    func makeHeaderProfileArea() -> some View {
        HStack(spacing: 32) {
            Image("dummyAvatar")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 120, maxHeight: 120)
                .clipShape(Circle())
                .overlay(
                    Button(action: {
                        // TODO: image picker profile
                    }, label: {
                        Image(systemName: "plus.app")
                            .padding(4)
                            .background(Color.white.clipShape(Capsule()))
                    })
                    .offset(x: 30, y: 45)
                )
                .shadow(radius: 4, x: 0, y: 2)
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.username.uppercased())
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.c595085)
                Text("Analyzer")
                    .font(.system(size: 12))
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                HStack {
                    Button {
                    } label: {
                        Text("Update Profile")
                            .font(.system(size: 10))
                            .fontWeight(.light)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 8)
                            .background(
                                Capsule()
                                    .fill(Color.c5CCBF1)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            )
                    }
                    Button {
                        viewModel.showActionSheetSignOut()
                    } label: {
                        Text("Log Out")
                            .font(.system(size: 10))
                            .fontWeight(.light)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 8)
                            .background(
                                Capsule()
                                    .fill(Color.white)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            )
                    }
                }
                .padding(.top, 8)
            }
        }
        .padding()
        .background(content: {
            Color.c745CF1
                .opacity(0.3)
                .cornerRadius(20)
        })
        .frame(maxWidth: .infinity)
    }

    func makeFamilyOnlineArea() -> some View {
        VStack(alignment: .leading) {
            Text("Family Member")
                .font(.system(size: 20))
                .fontWeight(.semibold)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Image("dummyAvatar")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 68, height: 68)
                        .padding(.bottom, 16)
                        .overlay(
                            Circle().fill(.green)
                                .frame(width: 10, height: 10)
                                .offset(x: 20, y: -25)
                        )
                        .background(
                            VStack {
                                Spacer()
                                Text("Alex")
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.cF18A5C)
                            }
                        )
                    Image("dummyAvatar")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 68, height: 68)
                        .padding(.bottom, 16)
                        .overlay(
                            Circle().fill(.green)
                                .frame(width: 10, height: 10)
                                .offset(x: 20, y: -25)
                        )
                        .background(
                            VStack {
                                Spacer()
                                Text("Aler")
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.cF18A5C)
                            }
                        )
                    Spacer()
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
