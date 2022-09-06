//
//  HomeView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/26/22.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel = HomeViewModel()

    var body: some View {
        TabView(selection: $viewModel.tabViewCurrentIndex) {
            Text("Home View")
                .tabItem {
                    Label("Home", systemImage: "house.circle")
                }
                .tag(0)
            DateMemoryView()
                .tabItem {
                    Label("Memories", systemImage: "arrow.clockwise.heart")
                }
                .tag(1)
            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "circle.grid.cross")
                }
                .tag(2)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.square")
                }
                .tag(3)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
