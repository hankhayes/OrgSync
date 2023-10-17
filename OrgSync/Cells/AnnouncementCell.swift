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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
