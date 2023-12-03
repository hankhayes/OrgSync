//
//  AnnouncementViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit

let milan = Member(firstName: "Milan", lastName: "Patel", birthday: 1001548800, classification: 3, role: "Social", phone:5125820924, email:"milan.patel@utexas.edu")

let announcements = [Announcement(subject: "Dues!", body: "Culpa ea commodo consectetur tempor duis eiusmod veniam. Consectetur amet officia veniam et excepteur reprehenderit esse sunt non nostrud enim.", announcer: milan, date: "Sep 24, 10:09 PM")]

class AnnouncementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let announcementCellIdentifier = "AnnouncementCell"
    let detailSegueIdentifier = "announcementToAnnouncementDetail"
    
    @IBOutlet weak var announcementTable: UITableView!
    @IBOutlet weak var announcementCard: UIView!
    @IBOutlet weak var announcementCardContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        announcementTable.delegate = self
        announcementTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if announcementTable.indexPathForSelectedRow != nil {
            announcementTable.deselectRow(at: announcementTable.indexPathForSelectedRow!, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcements.count
    }
    
    func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 144
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = announcementTable.dequeueReusableCell(withIdentifier: announcementCellIdentifier, for: indexPath as IndexPath) as! AnnouncementCell
        let row = indexPath.row
        let currentAnnouncer = announcements[row].announcer
        
        cell.announcerLabel.text = "\(currentAnnouncer.firstName) \(currentAnnouncer.lastName.first!)"
        cell.bodyLabel.text = announcements[row].body
        cell.subjectLabel.text = announcements[row].subject
        cell.dateLabel.text = announcements[row].date
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier,
           let destination = segue.destination as? AnnouncementDetailViewController,
           let announcementIndex = announcementTable.indexPathForSelectedRow?.row {
            let currentAnnouncer = announcements[announcementIndex].announcer
            destination.subject = announcements[announcementIndex].subject
            destination.announcer = "\(currentAnnouncer.firstName) \(currentAnnouncer.lastName.first!)"
            destination.date = announcements[announcementIndex].date
            destination.body = announcements[announcementIndex].body
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row")
    }
}
