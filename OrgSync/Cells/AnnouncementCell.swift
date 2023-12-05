//
//  AnnouncementCell.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit

class AnnouncementCell: UITableViewCell {
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var announcerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var announcementBackground: UIView!
    @IBOutlet weak var tagBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        announcementBackground.layer.cornerRadius = 10
    }
}
