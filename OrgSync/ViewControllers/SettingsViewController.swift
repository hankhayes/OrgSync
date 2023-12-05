//
//  SettingsViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/23/23.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    let ref = Database.database().reference(withPath: "users/\(Auth.auth().currentUser!.uid)")
    var delegate = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        let settingsTVC = self.children.first as? settingsTVC
        settingsTVC!.tableView.isScrollEnabled = false
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let profileVC = delegate as! FirebaseNameUpdater
        let settingsTVC = self.children.first as? settingsTVC
        
        // Capture new values
        let newFirstName = settingsTVC?.firstNameField.text
        let newLastName = settingsTVC?.lastNameField.text
        
        // Update the value in Firebase
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            let updatedFirstName = self.ref.child("firstName")
            updatedFirstName.setValue(newFirstName)
        })
        
        // Update the values in currentUser
        currentUser.firstName = newFirstName!
        currentUser.lastName = newLastName!
        
        // Update the value on the ProfileVC
        profileVC.updateName()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
