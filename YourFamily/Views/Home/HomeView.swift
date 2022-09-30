//
//  HomeView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/26/22.
//

import Combine
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        TabView(selection: $viewModel.tabViewCurrentIndex) {
            Text("Home View")
                .tabItem {
                    Label("Home", systemImage: "house.circle")
                }
                .tag(HomeViewModel.HomeTabView.home.tabIndexValue)
            DateMemoryView()
                .tabItem {
                    Label("Memories", systemImage: "arrow.clockwise.heart")
                }
                .tag(HomeViewModel.HomeTabView.memories.tabIndexValue)
            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "circle.grid.cross")
                }
                .tag(HomeViewModel.HomeTabView.setting.tabIndexValue)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.square")
                }
                .tag(HomeViewModel.HomeTabView.profile.tabIndexValue)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
