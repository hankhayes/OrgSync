//
//  MemberDetailViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/25/23.
//

import UIKit

class MemberDetailViewController: UIViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var firstName = ""
    var lastName = ""
    var birthday = ""
    var classification = 0
    var role = ""
    var phone = ""
    var email = ""
    var image = UIImage(named: "utaustin")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor(named: "burntorange")?.cgColor
        
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        birthdayLabel.text = birthday
        classificationLabel.text = String(classification)
        roleLabel.text = role
        phoneLabel.text = phone
        emailLabel.text = email
        imageView.image = image
        
    }
}
