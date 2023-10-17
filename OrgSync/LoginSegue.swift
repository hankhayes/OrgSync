//
//  loginSegue.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/3/23.
//

import UIKit

class LoginSegue: UIStoryboardSegue {
    
    override func perform() {
        let sourceViewController = self.source
        let destinationViewController = self.destination
        
        UIView.transition(
            from: sourceViewController.view,
            to: destinationViewController.view,
            duration: 0.5,
            options: .transitionCrossDissolve,
            completion: { finished in
                if finished {
//                    let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCTabBar") as? UITabBarController
//                    self.view.window?.rootViewController = homeViewController
//                    self.view.window?.makeKeyAndVisible()
                    
                }
            }
        )
    }
}
