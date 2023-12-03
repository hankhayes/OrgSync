//
//  Member.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit

class Member: Comparable, Equatable {
    static func < (lhs: Member, rhs: Member) -> Bool {
        let a = lhs.firstName[lhs.firstName.index(lhs.firstName.startIndex, offsetBy: 0)]
        let b = rhs.firstName[rhs.firstName.index(rhs.firstName.startIndex, offsetBy: 0)]
        return a < b
    }
    
    static func == (lhs: Member, rhs: Member) -> Bool {
        let a = lhs.firstName[lhs.firstName.index(lhs.firstName.startIndex, offsetBy: 0)]
        let b = rhs.firstName[rhs.firstName.index(rhs.firstName.startIndex, offsetBy: 0)]
        return a == b
    }
    
    
    var firstName:String
    var lastName:String
    var birthday:Int
    var classification:Int
    var role:String
    var phone:Int
    var email:String
    
    // initializes the Weapon class
    // sets damage based on the chosen weapon
    init(firstName:String, lastName:String, birthday:Int, classification:Int, role:String, phone:Int, email:String) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthday = birthday
        self.classification = classification
        self.role = role
        self.phone = phone
        self.email = email
    }
}
