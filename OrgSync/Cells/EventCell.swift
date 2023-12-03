//
//  EventCell.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit

class EventCell: UITableViewCell {
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventImage.backgroundColor = .cyan
    }
    

}
