//
//  EventsViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit

let events = [Event(title: "Paddleboarding", date: "September 27", coverImage: UIImage(named: "lakeaustin")!), Event(title: "Campus Social", date: "October 10", coverImage: UIImage(named: "utaustin")!)]

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let eventCellIdentifier = "EventCell"
    let detailSegueIdentifier = "eventToEventDetail"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventsTable: UITableView!
    @IBOutlet weak var titleBackground: UIView!
    @IBOutlet weak var summaryView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        eventsTable.delegate = self
        eventsTable.dataSource = self
        titleBackground.layer.cornerRadius = 20
        summaryView.layer.borderWidth = 2
        summaryView.layer.cornerRadius = 10
        summaryView.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if eventsTable.indexPathForSelectedRow != nil {
            eventsTable.deselectRow(at: eventsTable.indexPathForSelectedRow!, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 340
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventsTable.dequeueReusableCell(withIdentifier: eventCellIdentifier, for: indexPath as IndexPath) as! EventCell
        let row = indexPath.row
        
//        cell.eventTitle.text = events[row]
//        cell.eventDate.text = "September 27, 2023"
//        cell.eventImage.image = UIImage(named: "utaustin")
//        cell.eventImage.layer.cornerRadius = 10.0
        
        cell.eventTitle.text = events[row].title
        cell.eventDate.text = events[row].date
        cell.eventImage.image = events[row].coverImage
        cell.eventImage.layer.cornerRadius = 10
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier,
           let destination = segue.destination as? EventDetailViewController,
           let eventIndex = eventsTable.indexPathForSelectedRow?.row {
            destination.eventName = events[eventIndex].title
            destination.eventCoverImage = events[eventIndex].coverImage
            destination.eventTime = events[eventIndex].date
        }
    }
}

