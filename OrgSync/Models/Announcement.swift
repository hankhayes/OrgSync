//
//  Announcement.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit

class Announcement: Comparable, Equatable {
    
    static func < (lhs: Announcement, rhs: Announcement) -> Bool {
        let a = lhs.date
        let b = rhs.date
        return a < b
    }
    
    static func == (lhs: Announcement, rhs: Announcement) -> Bool {
        let a = lhs.date
        let b = rhs.date
        return a == b
    }
    
    var announcementID:String
    var subject:String
    var body:String
    var announcer:String
    var date:Date
    var tag:String
    
    // initializes the Weapon class
    // sets damage based on the chosen weapon
    init(announcementID: String, subject: String, body: String, announcer: String, date: Date, tag: String) {
        self.announcementID = announcementID
        self.subject = subject
        self.body = body
        self.announcer = announcer
        self.date = date
        self.tag = tag
    }
}

