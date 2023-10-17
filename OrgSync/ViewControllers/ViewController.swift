//
//  ViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

// Colors
// Space 25283D
// Plum 8F3985
// Blue 98DFEA
// Sea green 07BEB8
// Champagne EFD9CE

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var SeeEventsButton: UIButton!
    @IBOutlet weak var SeeMembersButton: UIButton!
    @IBOutlet weak var navbarView: UIView!
    
    let eventsSegueIdentifier = "mainToEvents"
    let membersSegueIdentifier = "mainToMembers"
    let announcementsSegueIdentifier = "mainToAnnouncements"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navbarView.layer.cornerRadius = 10
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == eventsSegueIdentifier,
           let destination = segue.destination as? EventsViewController {
            print("Moved to events")
        }
        if segue.identifier == membersSegueIdentifier,
           let destination = segue.destination as? MemberViewController {
            print("Moved to members")
        }
        if segue.identifier == announcementsSegueIdentifier,
           let destination = segue.destination as? AnnouncementViewController {
            print("Moved to announcements")
        }
    }
}

