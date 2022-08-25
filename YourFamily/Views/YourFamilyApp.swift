//
//  YourFamilyApp.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import SwiftUI
import FacebookCore

@main
struct YourFamilyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            AppRouterManager.shared.getRouterView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions:
                launchOptions
        )
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(
            app,
            open: url,
            options: options
        )
    }
}
