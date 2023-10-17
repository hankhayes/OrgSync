//
//  LoginViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/3/23.
//

import UIKit
import Firebase

let defaults = UserDefaults.standard

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        print(defaults.dictionaryRepresentation())
    }
}
