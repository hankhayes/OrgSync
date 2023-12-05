//
//  settingsTVC.swift
//  OrgSync
//
//  Created by Hank Hayes on 11/1/23.
//

import UIKit
import Firebase
import FirebaseAuth

class settingsTVC: UITableViewController, UITextFieldDelegate {
    
    private let ref = Database.database().reference(withPath: "users/hank")
    
    @IBOutlet weak var appearanceSegmentControl: UISegmentedControl!
    @IBOutlet weak var hapticSwitch: UISwitch!
    @IBOutlet weak var appIconSegemtControl: UISegmentedControl!
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.string(forKey: "appearance") == "light" {
            appearanceSegmentControl.selectedSegmentIndex = 0
        } else if defaults.string(forKey: "appearance") == "dark" {
            appearanceSegmentControl.selectedSegmentIndex = 1
        } else {
            appearanceSegmentControl.selectedSegmentIndex = 2
        }
        
        if defaults.string(forKey: "appIcon") == "classic" {
            appIconSegemtControl.selectedSegmentIndex = 0
        } else if defaults.string(forKey: "appIcon") == "dark" {
            appIconSegemtControl.selectedSegmentIndex = 1
        } else if defaults.string(forKey: "appIcon") == "reverse" {
            appIconSegemtControl.selectedSegmentIndex = 2
        }
        
        if defaults.bool(forKey: "hapticPreference") {
            hapticSwitch.isOn = true
        } else {
            hapticSwitch.isOn = false
        }
        
        firstNameField.text = currentUser.firstName
        lastNameField.text = currentUser.lastName
        
        firstNameField.delegate = self
        lastNameField.delegate = self
    }
    
    @IBAction func appearanceChanged(_ sender: Any) {
        switch appearanceSegmentControl.selectedSegmentIndex {
        case 0:
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first {
                    print(window)
                    print(window.isKeyWindow)
                    defaults.set("light", forKey: "appearance")
                    window.overrideUserInterfaceStyle = .light
                }
            }
        case 1:
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first {
                    print(window)
                    print(window.isKeyWindow)
                    defaults.set("dark", forKey: "appearance")
                    window.overrideUserInterfaceStyle = .dark
                }
            }
        case 2:
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first {
                    print(window)
                    print(window.isKeyWindow)
                    defaults.set("unspecified", forKey: "appearance")
                    window.overrideUserInterfaceStyle = .unspecified
                }
            }
        default:
            print("this shouldn't happen")
        }
    }
    
    @IBAction func appIconChanged(_ sender: Any) {
        switch appIconSegemtControl.selectedSegmentIndex {
        case 0:
            UIApplication.shared.setAlternateIconName(nil) { (error) in
                if let error = error {
                    print("Failed request to update the app’s icon: \(error)")
                }
            }
            defaults.set("classic", forKey: "appIcon")
        case 1:
            UIApplication.shared.setAlternateIconName("orgsync-dark") { (error) in
                if let error = error {
                    print("Failed request to update the app’s icon: \(error)")
                }
            }
            defaults.set("dark", forKey: "appIcon")
        case 2:
            UIApplication.shared.setAlternateIconName("orgsync-reverse") { (error) in
                if let error = error {
                    print("Failed request to update the app’s icon: \(error)")
                }
            }
            defaults.set("reverse", forKey: "appIcon")
        default:
            print("this shouldn't happen")
        }
    }
    
    @IBAction func hapticSwitchChanged(_ sender: Any) {
        switch hapticSwitch.isOn {
        case true:
            defaults.set(true, forKey: "hapticPreference")
        case false:
            defaults.set(false, forKey: "hapticPreference")
        }
    }
    
    @IBAction func changePasswordButtonPressed(_ sender: Any) {
        
        let currentUser = Auth.auth().currentUser
        
        let changePasswordAlert = UIAlertController(title: "Change Password", message: "Fill out the following fields", preferredStyle: .alert)

        changePasswordAlert.addTextField() {
            (newPassword) in newPassword.placeholder = "New password"
        }
        
        changePasswordAlert.addTextField() {
            (repeatNewPassword) in repeatNewPassword.placeholder = "Repeat new password"
        }
        
        changePasswordAlert.addAction(UIAlertAction(title: "Save", style: .default) {
            (action) in
            let newPasswordField = changePasswordAlert.textFields![0]
            let repeatNewPasswordField = changePasswordAlert.textFields![1]
            
            guard newPasswordField.text?.isEmpty == false else {return}
            
            currentUser?.updatePassword(to: newPasswordField.text!) {
                error in
                if let error = error {
                    print(error)
                }
            }
        })
        
        present(changePasswordAlert, animated: true) {
            print("hi")
        }
        
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true)
        } catch {
            print("Sign out error")
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
}
