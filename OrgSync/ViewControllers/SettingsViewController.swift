//
//  SettingsViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/23/23.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let settingsTVC = self.children.first as? settingsTVC
        settingsTVC!.tableView.isScrollEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // super.viewDidAppear(true)
        print("Settings appeared")
        print(navigationController?.viewControllers)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Settings DISappeared")
    }
}
