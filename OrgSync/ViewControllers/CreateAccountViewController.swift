//
//  CreateAccountViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/3/23.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    private let ref = Database.database().reference(withPath: "users")
    
    let loginSegue = "successfulLoginSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
    }
    
    // Called when 'return' key pressed

    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        
    // Called when the user clicks on the view outside of the UITextField

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
    }
}
