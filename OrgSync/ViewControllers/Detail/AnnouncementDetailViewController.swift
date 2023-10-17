//
//  AnnouncementDetailViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/27/23.
//

import UIKit

class AnnouncementDetailViewController: UIViewController {
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var announcerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var subject = ""
    var announcer = ""
    var date = ""
    var body = ""
    
    override func viewDidLoad() {
        subjectLabel.text = subject
        announcerLabel.text = announcer
        dateLabel.text = date
        bodyLabel.text = body
    }
}
