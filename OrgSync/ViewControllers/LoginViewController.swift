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
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Called when a user logs in
    @IBAction func loginButtonPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) {
            (authResult, error) in
            if let error = error as NSError? {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Successful login")
                let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCTabBar")
                destinationVC?.modalPresentationStyle = .fullScreen
                self.present(destinationVC!, animated: true)
            }
        }
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
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}
