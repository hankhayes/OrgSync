//
//  AnnouncementViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit
import Firebase

class AnnouncementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let announcementCellIdentifier = "AnnouncementCell"
    let detailSegueIdentifier = "announcementToAnnouncementDetail"
    
    @IBOutlet weak var announcementTable: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    
    // Database reference
    private let ref = Database.database().reference().child("announcements")
    
    var firebaseAnnouncements = [Announcement]()
    var filteredAnnouncements = [Announcement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        announcementTable.delegate = self
        announcementTable.dataSource = self
        
        // Creating the add menu
        let addMenu = UIMenu(options: .displayInline, children: [
            UIAction(title: "New announcement", image: UIImage(systemName: "plus"), handler: {_ in
                self.performSegue(withIdentifier: "newAnnouncement", sender: nil)
            })
        ])
        
        // Creating the filter menu
        let filterMenu = UIMenu(title: "Filter by tag", options: [.displayInline, .singleSelection], children: [
            UIAction(title: "All", state: .on, handler: {_ in
                self.filteredAnnouncements = []
                for announcement in self.firebaseAnnouncements {
                    self.filteredAnnouncements.append(announcement)
                }
                self.filteredAnnouncements.sort()
                // Reloads the table data after ALL is selected
                self.announcementTable.reloadData()
            }),
            UIAction(title: "Social", handler: {_ in
                self.filteredAnnouncements = []
                for announcement in self.firebaseAnnouncements {
                    if announcement.tag == "social" {
                        self.filteredAnnouncements.append(announcement)
                    }
                }
                self.filteredAnnouncements.sort()
                // Reloads the table data after ALL is selected
                self.announcementTable.reloadData()
            }),
            UIAction(title: "Philanthropy", handler: {_ in
                self.filteredAnnouncements = []
                for announcement in self.firebaseAnnouncements {
                    if announcement.tag == "philanthropy" {
                        self.filteredAnnouncements.append(announcement)
                    }
                }
                self.filteredAnnouncements.sort()
                // Reloads the table data after ALL is selected
                self.announcementTable.reloadData()
            }),
            UIAction(title: "Finance", handler: {_ in
                self.filteredAnnouncements = []
                for announcement in self.firebaseAnnouncements {
                    if announcement.tag == "finance" {
                        self.filteredAnnouncements.append(announcement)
                    }
                }
                self.filteredAnnouncements.sort()
                // Reloads the table data after ALL is selected
                self.announcementTable.reloadData()
            }),
            UIAction(title: "General", handler: {_ in
                self.filteredAnnouncements = []
                for announcement in self.firebaseAnnouncements {
                    if announcement.tag == "general" {
                        self.filteredAnnouncements.append(announcement)
                    }
                }
                self.filteredAnnouncements.sort()
                // Reloads the table data after ALL is selected
                self.announcementTable.reloadData()
            })
        ])
        
        var mainMenu = UIMenu()
        
        // Assing the main menu based on user role
        if currentUser.role != "member" {
            mainMenu = UIMenu(children: [
                filterMenu,
                addMenu
            ])
        } else {
            mainMenu = UIMenu(children: [
                filterMenu
            ])
        }
        
        filterButton.menu = mainMenu
        
        // Calls fetchFirebaseAnnouncements
        fetchFirebaseAnnouncements()
        
        // Creates refresh functionality
        announcementTable.refreshControl = UIRefreshControl()
        announcementTable.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
        
        // Dismiss the keyboard on dragging eventsTable
        announcementTable.keyboardDismissMode = .onDrag
        
    }
    
    @objc func callPullToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.announcementTable.refreshControl?.endRefreshing()
            self.fetchFirebaseAnnouncements()
            self.announcementTable.reloadData()
        }
    }
    
    func fetchFirebaseAnnouncements() {
        // Clears both announcement arrays
        firebaseAnnouncements.removeAll()
        filteredAnnouncements.removeAll()
        
        // Observes Firebase Database
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            // Iterates through every member in Firebase
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let childData = childSnapshot.value as? [String: Any],
                   let fbSubject = childData["subject"] as? String,
                   let fbAnnouncementID = childData["announcementID"] as? String,
                   let fbBody = childData["body"] as? String,
                   let fbAnnouncer = childData["announcer"] as? String,
                   let fbDate = childData["date"] as? Double,
                   let fbTag = childData["tag"] as? String {
                    // Creates a firebaseAnnouncement
                    let convertedDate = Date(timeIntervalSince1970: fbDate)
                    let firebaseAnnouncement = Announcement(announcementID: fbAnnouncementID, subject: fbSubject, body: fbBody, announcer: fbAnnouncer, date: convertedDate, tag: fbTag)
                    
                    // Adds firebaseAnnouncement to firebaseAnnouncements
                    self.firebaseAnnouncements.append(firebaseAnnouncement)
                    
                    // Adds firebaseMember only if they are part of the current filter group
                    switch self.filterButton.menu?.selectedElements.first?.title {
                    case "All":
                        self.filteredAnnouncements.append(firebaseAnnouncement)
                    case "Social":
                        if firebaseAnnouncement.tag == "social" {
                            self.filteredAnnouncements.append(firebaseAnnouncement)
                        }
                    case "Philanthropy":
                        if firebaseAnnouncement.tag == "philanthropy" {
                            self.filteredAnnouncements.append(firebaseAnnouncement)
                        }
                    default:
                        print("unknown")
                    }
                }
            }
            // Reloads memberTable
            self.filteredAnnouncements.sort()
            self.announcementTable.reloadData()
        })
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if announcementTable.indexPathForSelectedRow != nil {
            announcementTable.deselectRow(at: announcementTable.indexPathForSelectedRow!, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAnnouncements.count
    }
    
    func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 144
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = announcementTable.dequeueReusableCell(withIdentifier: announcementCellIdentifier, for: indexPath as IndexPath) as! AnnouncementCell
        let row = indexPath.row
        
        cell.announcerLabel.text = filteredAnnouncements[row].announcer
        cell.bodyLabel.text = filteredAnnouncements[row].body
        cell.subjectLabel.text = filteredAnnouncements[row].subject
        cell.tagLabel.text = filteredAnnouncements[row].tag
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy h:mma"
        let formattedDate = dateFormatter.string(from: filteredAnnouncements[row].date)
        cell.dateLabel.text = formattedDate
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier,
           let destination = segue.destination as? AnnouncementDetailViewController,
           let announcementIndex = announcementTable.indexPathForSelectedRow?.row {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy h:mma"
            let formattedDate = dateFormatter.string(from: filteredAnnouncements[announcementIndex].date)
            
            destination.announcer = filteredAnnouncements[announcementIndex].announcer
            destination.subject = filteredAnnouncements[announcementIndex].subject
            destination.date = formattedDate
            destination.body = filteredAnnouncements[announcementIndex].body
            destination.tag = filteredAnnouncements[announcementIndex].tag
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row")
    }
}
