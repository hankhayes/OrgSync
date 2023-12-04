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
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagBackground: UIView!
    
    var subject = ""
    var announcer = ""
    var date = ""
    var body = ""
    var tag = ""
    
    override func viewDidLoad() {
        subjectLabel.text = subject
        announcerLabel.text = announcer
        dateLabel.text = date
        bodyLabel.text = body
        tagLabel.text = tag
        
        tagBackground.layer.cornerRadius = 10
    }
}
