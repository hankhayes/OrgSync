//
//  EditProfileTVC.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/25/23.
//

import UIKit
import Firebase

class EditProfileTVC: UITableViewController {
    
    private let ref = Database.database().reference(withPath: "users/hank")
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameField.text = currentUser.firstName
        lastNameField.text = currentUser.lastName
    }
}
