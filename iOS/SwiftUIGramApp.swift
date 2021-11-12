//
//  SwiftUIGramApp.swift
//  Shared
//
//  Created by Flávio Silvério on 08/10/2021.
//

import SwiftUI

@main
struct SwiftUIGramApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            TabView {
                Feed()
                    .tabItem {
                        Label("Feed", systemImage: "text.justify")
                    }

                Text("Discover Tab")
                    .tabItem {
                        Label("Discover", systemImage: "wand.and.rays")
                    }

                Text("Discover Tab")
                    .tabItem {
                        Label("Upload", systemImage: "plus.app.fill")
                    }

                Text("Discover Tab")
                    .tabItem {
                        Label("Saved", systemImage: "folder.fill")
                    }

                Text("Discover Tab")
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
        }
    }
}
