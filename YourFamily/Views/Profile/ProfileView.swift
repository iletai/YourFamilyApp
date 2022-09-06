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
                HStack(spacing: 12) {
                    Image(systemName: "star")
                        .overlay(
                            RoundedRectangle(cornerRadius: 16).stroke().fill(Color.blue).frame(width: 34, height: 24)
                        )
                    Text("Hello, Tai Le!")
                    Spacer()
                }
                Spacer()
            }
            .padding(16)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
