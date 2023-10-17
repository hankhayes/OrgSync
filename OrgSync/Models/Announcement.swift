//
//  Announcement.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit

class Announcement {
    var subject:String
    var body:String
    var announcer:Member
    var date:String
    
    // initializes the Weapon class
    // sets damage based on the chosen weapon
    init(subject:String, body:String, announcer:Member, date:String) {
        self.subject = subject
        self.body = body
        self.announcer = announcer
        self.date = date
    }
}

