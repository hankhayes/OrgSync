//
//  ProfileViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/1/23.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var titleBackground: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    let currentUID = Auth.auth().currentUser!.uid
    let ref = Database.database().reference(withPath: "users")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        titleBackground.layer.cornerRadius = 20
        
        let userRef = ref.child("\(currentUID)")
        
        ref.observe(.value, with: {snapshot in
            print(snapshot.value as Any)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userRef = ref.child("\(currentUID)")
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? [String: Any] {
                let firstName = value["firstName"] as? String
                self.firstNameLabel.text = firstName
            }
        }
    }
    
    
}
