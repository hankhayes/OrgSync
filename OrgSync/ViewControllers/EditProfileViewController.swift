//
//  EditProfileViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/3/23.
//

import UIKit
import Firebase

class EditProfileViewController: UITableViewController {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    private let ref = Database.database().reference(withPath: "users/hank")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        let newFirstName = firstNameField.text!
        let newLastName = lastNameField.text!
        let newEmail = emailField.text!
        let newPhone = phoneField.text!
        
        ref.observe(.value, with: {(snapshot) in
            
            let newItem = [
                "firstName": newFirstName,
                "lastName": newLastName,
                "birthday": "92701",
                "phone": newPhone,
                "email": newEmail,
                "classification": 3
            ]
            
            self.ref.setValue(newItem)
        })
    }
}
