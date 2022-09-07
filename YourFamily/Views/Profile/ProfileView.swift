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
        ZStack {
            VStack {
                Image("dummyAvatar")
                    .resizable()
                    .aspectRatio(9 / 16, contentMode: .fit)
                Spacer()

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            LinearGradient(
                colors: [
                    Color.c232020,
                    Color.c232020,
                    Color.c232020.opacity(0.5484),
                    Color.c232020.opacity(0),
                ], startPoint: .bottom, endPoint: .top)
            VStack {
                HStack {
                    Text("Alex Dimigo")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    .foregroundColor(.white)
                    Spacer()
                }
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
