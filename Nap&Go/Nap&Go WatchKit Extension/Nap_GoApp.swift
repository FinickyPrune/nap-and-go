//
//  Nap_GoApp.swift
//  Nap&Go WatchKit Extension
//
//  Created by Анастасия Кравченко on 10.08.2022.
//

import SwiftUI

@main
struct Nap_GoApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
