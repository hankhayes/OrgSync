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
    
    
    
    
    private let ref = Database.database().reference(withPath: "users/hank")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        titleBackground.layer.cornerRadius = 20
    }
}
