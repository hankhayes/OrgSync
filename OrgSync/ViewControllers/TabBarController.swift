//
//  TabBarController.swift
//  OrgSync
//
//  Created by Hank Hayes on 11/2/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch defaults.string(forKey: "appearance") {
        case "dark":
            overrideUserInterfaceStyle = .dark
        case "light":
            overrideUserInterfaceStyle = .light
        default:
            overrideUserInterfaceStyle = .unspecified
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let hapticPreference = defaults.value(forKey: "hapticPreference") as? Bool {
            if hapticPreference {
                let feedbackGenerator = UINotificationFeedbackGenerator()
                feedbackGenerator.prepare()
                feedbackGenerator.notificationOccurred(.success)
            }
        }
    }
}
