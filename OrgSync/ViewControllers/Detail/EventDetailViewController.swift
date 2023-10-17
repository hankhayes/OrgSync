//
//  EventDetailViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/25/23.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var eventName = ""
    var eventTime = ""
    var eventLocation = ""
    var eventNotes = ""
    var eventCoverImage = UIImage(named: "hank")
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var whenLabel: UILabel!
    @IBOutlet weak var whereLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    override func viewDidLoad() {
        eventNameLabel.text = eventName
        whenLabel.text = eventTime
        whereLabel.text = eventLocation
        notesLabel.text = eventNotes
        eventImage.image = eventCoverImage
    }
}
