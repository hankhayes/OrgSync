//
//  Event.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit

class Event {
    
    var title:String
    var date:String
    var coverImage:UIImage
    
    // initializes the Weapon class
    // sets damage based on the chosen weapon
    init(title:String, date:String, coverImage:UIImage) {
        self.title = title
        self.date = date
        self.coverImage = coverImage
    }
}
