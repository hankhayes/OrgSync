//
//  EventDetailViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/25/23.
//

import UIKit
import MapKit

class EventDetailViewController: UIViewController {
    
    var eventName = ""
    var eventDate = ""
    var eventLocation = ""
    var eventNotes = ""
    var eventCoverImage = UIImage(named: "utaustin")
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var whenLabel: UILabel!
    @IBOutlet weak var whereLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    override func viewDidLoad() {
        eventNameLabel.text = eventName
        whenLabel.text = eventDate
        whereLabel.text = eventLocation
        notesLabel.text = eventNotes
        eventImage.image = eventCoverImage
    }
}
