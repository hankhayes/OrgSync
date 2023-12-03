//
//  EditProfileViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/3/23.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController {
    
    let ref = Database.database().reference(withPath: "users/\(Auth.auth().currentUser!.uid)")
    var delegate = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let editProfileTVC = self.children.first as? EditProfileTVC
        editProfileTVC!.tableView.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let editProfileTVC = self.children.first as? EditProfileTVC
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("EP view did appear")
        print(navigationController?.viewControllers)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("EP view did disappear")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        let profileVC = delegate as! FirebaseNameUpdater
        let editProfileTVC = self.children.first as? EditProfileTVC
        
        // Capture new values
        let newFirstName = editProfileTVC?.firstNameField.text
        let newLastName = editProfileTVC?.lastNameField.text
        let newPhone = editProfileTVC?.phoneField.text
        
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
}
