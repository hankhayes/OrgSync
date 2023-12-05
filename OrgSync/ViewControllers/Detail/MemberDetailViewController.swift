//
//  MemberDetailViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/25/23.
//

import UIKit
import Foundation

class MemberDetailViewController: UIViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var firstName = ""
    var lastName = ""
    var birthday = 0
    var classification = 0
    var role = ""
    var phone = 0
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        
        // Setting birthday
        birthdayLabel.text = convertUnixTimeToRegularDate(unixTime: TimeInterval(birthday))
        
        switch classification {
        case 0:
            classificationLabel.text = "Freshman"
        case 1:
            classificationLabel.text = "Sopohmore"
        case 2:
            classificationLabel.text = "Junior"
        case 3:
            classificationLabel.text = "Senior"
        default:
            classificationLabel.text = "Alumni"
        }
        
        roleLabel.text = role
        phoneLabel.text = String(phone)
        emailLabel.text = email
    }
    
    func convertUnixTimeToRegularDate(unixTime: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY" // You can customize the date format as needed
        
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
