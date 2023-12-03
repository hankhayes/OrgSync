//
//  EnterLeftSegue.swift
//  OrgSync
//
//  Created by Hank Hayes on 11/10/23.
//

import UIKit

class EnterLeftSegue: UIStoryboardSegue {
    override func perform() {
        // Hide the back button
        self.source.navigationItem.hidesBackButton = true
        self.destination.navigationItem.hidesBackButton = true

        // Create a custom transition animation
        let transition = CATransition()
        transition.type = .push
        transition.subtype = .fromLeft
        transition.duration = 0.5
        
        // Makes the transition ease in out
        transition.timingFunction = CAMediaTimingFunction(name: .default)
        
        self.source.view.window?.layer.add(transition, forKey: kCATransition)
        
        // Apply the custom transition animation to the window's layer
        self.source.navigationController?.pushViewController(self.destination, animated: false)
    }
}