//
//  AppDelegate.swift
//  SwiftUIGram (iOS)
//
//  Created by Flávio Silvério on 12/11/2021.
//

import Foundation
import UIKit
import Parse

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        Parse.initialize(with: .defaultConfiguration)

        return true
    }
}

extension ParseClientConfiguration {
    static var defaultConfiguration: ParseClientConfiguration  {
        return ParseClientConfiguration {
            $0.applicationId = ParseConfiguration.appID
            $0.clientKey = ParseConfiguration.appKey
            $0.server = ParseConfiguration.databaseURL
        }
    }
}
