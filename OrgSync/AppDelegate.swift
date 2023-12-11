//
//  AppDelegate.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit
import Firebase

let currentUser = CurrentMember(
    firstName: "",
    lastName: "",
    birthday: 0,
    classification: 0,
    role: "",
    phone: 0,
    email: ""
)

@main
// @UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        // Light/Dark/Dynamic appearance
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                // window.backgroundColor = .white
                // window.tintColor = .white
                if let selectedAppearance = UserDefaults.standard.string(forKey: "appearance") {
                    if selectedAppearance == "dark" {
                        window.overrideUserInterfaceStyle = .dark
                    } else if selectedAppearance == "light" {
                        window.overrideUserInterfaceStyle = .light
                    }
                } else {
                    window.overrideUserInterfaceStyle = .dark
                }
            }
        }

        // Haptic feedback
        if let _ = UserDefaults.standard.value(forKey: "hapticPreference") as? Bool {
        } else {
            UserDefaults.standard.set(true, forKey: "hapticPreference")
        }
        
        // App Icon
        if let _ = UserDefaults.standard.value(forKey: "appIcon") as? String {
        } else {
            UserDefaults.standard.setValue("classic", forKey: "appIcon")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
