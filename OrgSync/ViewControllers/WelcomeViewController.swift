//
//  WelcomeViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 11/2/23.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let abstractBackground = welcomeDrawing(frame: view.bounds)
//        abstractBackground.backgroundColor = .clear
//        view.addSubview(abstractBackground)
        // This code automaticall logs you in if you have previously logged in
        Auth.auth().addStateDidChangeListener() {
            (auth,user) in
            if user != nil {
                
                self.fillInCurrentUser()
                
                let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCTabBar")
                destinationVC?.modalPresentationStyle = .fullScreen
                self.present(destinationVC!, animated: true)
            }
        }
    }
    
    func fillInCurrentUser() {
        let ref = Database.database().reference(withPath: "users")
        let currentUID = Auth.auth().currentUser!.uid
        let userRef = ref.child("\(currentUID)")
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? [String: Any] {
                print(value["firstName"] as! String)
                currentUser.firstName = value["firstName"] as! String
                currentUser.lastName = value["lastName"] as! String
                currentUser.birthday = value["birthday"] as! Int
                currentUser.classification = value["classification"] as! Int
                currentUser.role = value["role"] as! String
                currentUser.phone = value["phone"] as! Int
                currentUser.email = value["email"] as! String
            }
        }
        print("filled in current user")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("view did disappear")
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let destinationVC = storyboard?.instantiateViewController(identifier: "login")
        let presentationDelegate = PresentRight()
        destinationVC?.modalPresentationStyle = .custom
        destinationVC?.transitioningDelegate = presentationDelegate
        present(destinationVC!, animated: true)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let destinationVC = storyboard?.instantiateViewController(identifier: "signup")
        let presentationDelegate = PresentRight()
        destinationVC?.modalPresentationStyle = .custom
        destinationVC?.transitioningDelegate = presentationDelegate
        
        present(destinationVC!, animated: true)
    }
    
    @IBAction func unwind(for unwindSegue: ExitLeftSegue, towards subsequentVC: UIViewController) {
    }
}

