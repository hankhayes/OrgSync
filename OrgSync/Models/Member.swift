//
//  Member.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit

class Member {
    
    var firstName:String
    var lastName:String
    var dob:String
    var classification:Int
    var role:String
    var phone:String
    var email:String
    
    // initializes the Weapon class
    // sets damage based on the chosen weapon
    init(firstName:String, lastName:String, dob:String, classification:Int, role:String, phone:String, email:String) {
        self.firstName = firstName
        self.lastName = lastName
        self.dob = dob
        self.classification = classification
        self.role = role
        self.phone = phone
        self.email = email
    }
}
