//
//  Event.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit

class Event: Comparable, Equatable {
    
    static func < (lhs: Event, rhs: Event) -> Bool {
        let a = lhs.date
        let b = rhs.date
        return a < b
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        let a = lhs.date
        let b = rhs.date
        return a == b
    }
    
    var eventID:String
    var title:String
    var date:Date
    var notes:String
    var location:String
    
    // initializes the Weapon class
    // sets damage based on the chosen weapon
    init(eventID: String, title: String, date: Date, notes: String, location: String) {
        self.eventID = eventID
        self.title = title
        self.date = date
        self.notes = notes
        self.location = location
    }
}
