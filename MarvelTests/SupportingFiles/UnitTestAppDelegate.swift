//
//  UnitTestAppDelegate.swift
//  MarvelTests
//
//  Created by Vicente Ortega Aguado on 01/07/2021.
//

import UIKit

@objc(UnitTestAppDelegate)
final class UnitTestAppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Remove any cached scene configurations
        for sceneSession in application.openSessions {
            application.perform(Selector(("_removeSessionFromSessionSet:")), with: sceneSession)
        }
        print("UnitTestSceneDelegate")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = UnitTestSceneDelegate.self
        sceneConfiguration.storyboard = nil

        return sceneConfiguration
    }
}
