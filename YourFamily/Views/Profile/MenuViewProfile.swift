//
//  MenuViewProfile.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/26/22.
//

import SwiftUI

struct MenuViewProfile: View {
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                HStack {
                    Image("dummyAvatar")
                        .resizable(resizingMode: .stretch)
                        .scaledToFit()
                        .clipShape(Circle())
                    .frame(width: 48, height: 48)
                    Spacer()
                }
                HStack {
                    Text("Hello, Tai Le!")
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
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
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
        MenuViewProfile()
    }
}
