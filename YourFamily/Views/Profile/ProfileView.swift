//
//  ProfileView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/26/22.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color.c745CF1
                    .opacity(0.1)
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    makeHeaderProfileArea()
                    makeCenterProfileArea()
                    makeCenterProfileArea()
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
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
            .navigationBarItems(
                leading:
                    Button(
                        action: {
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

    func makeHeaderProfileArea() -> some View {
        HStack(spacing: 8) {
            Image("dummyAvatar")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 120, maxHeight: 120)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 4) {
                Text("Angelica Jackson")
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
                                    .strokeBorder(Color.blue, lineWidth: 1)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            )
                    }
                    Button {
                    } label: {
                        Text("Log Out")
                            .font(.system(size: 10))
                            .fontWeight(.light)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 8)
                            .background(
                                Capsule()
                                    .strokeBorder(Color.blue, lineWidth: 1)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            )
                    }
                }
                .padding(.top, 8)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
