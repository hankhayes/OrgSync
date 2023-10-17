//
//  CreateAnnouncementViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/1/23.
//

import UIKit

class CreateAnnouncementViewController: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.borderWidth = 2
        submitButton.layer.cornerRadius = 10
        submitButton.layer.borderColor = UIColor(named: "burntorange")?.cgColor
        
    }
}
