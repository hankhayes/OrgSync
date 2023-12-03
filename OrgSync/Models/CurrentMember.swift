//
//  CurrentMember.swift
//  OrgSync
//
//  Created by Hank Hayes on 11/21/23.
//

import UIKit

class CurrentMember {
    var firstName:String
    var lastName:String
    var birthday:Int
    var classification:Int
    var role:String
    var phone:Int
    var email:String
    
    init(firstName: String, lastName: String, birthday: Int, classification: Int, role: String, phone: Int, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthday = birthday
        self.classification = classification
        self.role = role
        self.phone = phone
        self.email = email
    }
}
