//
//  EventsViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit
import Firebase

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SuccessNotifier {
    
    var firebaseEvents = [Event]()
    var filteredEvents = [Event]()
    
    let eventCellIdentifier = "EventCell"
    let detailSegueIdentifier = "eventToEventDetail"
    
    private let ref = Database.database().reference().child("events")
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventsTable: UITableView!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        eventsTable.delegate = self
        eventsTable.dataSource = self
        searchBar.delegate = self
        summaryView.layer.borderWidth = 1
        summaryView.layer.cornerRadius = 10
        summaryView.layer.borderColor = UIColor.gray.cgColor

        // Creating the add menu
        let addMenu = UIMenu(options: .displayInline, children: [
            UIAction(title: "New event", image: UIImage(systemName: "plus"), handler: {_ in
                self.performSegue(withIdentifier: "newEvent", sender: nil)
            })
        ])
        
        // Creating the filter menu
        let filterMenu = UIMenu(title: "Filter by", options: [.displayInline, .singleSelection], children: [
            UIAction(title: "Upcoming", state: .on, handler: {_ in
                self.filteredEvents = []
                for event in self.firebaseEvents {
                    if event.date > Date() {
                        self.filteredEvents.append(event)
                    }
                }
                self.filteredEvents.sort()
                // Reloads the table data after ALL is selected
                self.eventsTable.reloadData()
            }),
            UIAction(title: "Past", handler: {_ in
                self.filteredEvents = []
                for event in self.firebaseEvents {
                    if event.date < Date() {
                        self.filteredEvents.append(event)
                    }
                }
                self.filteredEvents.sort()
                // Reloads the table data after ALL is selected
                self.eventsTable.reloadData()
            }),
        ])
        
        var mainMenu = UIMenu()
        
        // Assign the main menu based on user role
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
    
        // Calls fetchFirebaseEvents
        fetchFirebaseEvents()
        
        // Creates refresh functionality
        eventsTable.refreshControl = UIRefreshControl()
        eventsTable.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
    
        // Dismiss the keyboard on dragging eventsTable
        eventsTable.keyboardDismissMode = .onDrag
        
        // Add a gesture recognizer to the summary view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSummaryTap(_:)))
        summaryView.addGestureRecognizer(tapGesture)
        summaryView.isUserInteractionEnabled = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if eventsTable.indexPathForSelectedRow != nil {
            eventsTable.deselectRow(at: eventsTable.indexPathForSelectedRow!, animated: false)
        }
    }
    
    // Called when memberTable is refreshed by a pull gesture
    @objc func callPullToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.eventsTable.refreshControl?.endRefreshing()
            self.fetchFirebaseEvents()
            self.eventsTable.reloadData()
        }
    }
    
    func fetchFirebaseEvents() {
        // Clears both member arrays
        firebaseEvents.removeAll()
        filteredEvents.removeAll()
        
        // Observes Firebase Database
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let childData = childSnapshot.value as? [String: Any],
                   let fbTitle = childData["title"] as? String,
                   let fbEventID = childData["eventID"] as? String,
                   let fbDate = childData["date"] as? Double,
                   let fbNotes = childData["notes"] as? String,
                   let fbLocation = childData["location"] as? String {
                    // Create a new Event
                    let convertedDate = Date(timeIntervalSince1970: fbDate)
                    let firebaseEvent = Event(eventID: fbEventID, title: fbTitle, date: convertedDate, notes: fbNotes, location: fbLocation)
                    
                    // Add firebaseEvent to firebaseEvents
                    self.firebaseEvents.append(firebaseEvent)
                    
                    // Add firebaseEvent only if they are part of the current filter group
                    switch self.filterButton.menu?.selectedElements.first?.title {
                    case "Upcoming":
                        if firebaseEvent.date > Date() {
                            self.filteredEvents.append(firebaseEvent)
                        }
                    case "Past":
                        if firebaseEvent.date < Date() {
                            self.filteredEvents.append(firebaseEvent)
                        }
                    default:
                        print("unknown")
                    }
                }
            }
            self.filteredEvents.sort()
            self.eventsTable.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvents.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 340
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventsTable.dequeueReusableCell(withIdentifier: eventCellIdentifier, for: indexPath as IndexPath) as! EventCell
        let row = indexPath.row
        
//        cell.eventTitle.text = events[row]
//        cell.eventDate.text = "September 27, 2023"
        cell.eventImage.image = UIImage(named: "utaustin")
        cell.eventImage.layer.cornerRadius = 10.0
        
        cell.eventTitle.text = filteredEvents[row].title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy h:mma"
        let formattedDate = dateFormatter.string(from: filteredEvents[row].date)
        cell.eventDate.text = formattedDate
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier,
           let destination = segue.destination as? EventDetailViewController,
           let eventIndex = eventsTable.indexPathForSelectedRow?.row {
            destination.eventName = filteredEvents[eventIndex].title
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy h:mma"
            let formattedDate = dateFormatter.string(from: filteredEvents[eventIndex].date)
            destination.eventDate = formattedDate
            destination.date = filteredEvents[eventIndex].date
            
            destination.eventLocation = filteredEvents[eventIndex].location
            destination.eventNotes = filteredEvents[eventIndex].notes
        }
        if segue.identifier == "newEvent",
           let destination = segue.destination as? CreateEventViewController {
            print()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredEvents = []
            for event in firebaseEvents {
                switch filterButton.menu?.selectedElements.first?.title {
                case "Upcoming":
                    if event.date > Date() {
                        filteredEvents.append(event)
                    }
                case "Past":
                    if event.date < Date() {
                        filteredEvents.append(event)
                    }
                default:
                    print("unknown")
                }
            }
            eventsTable.reloadData()
        } else {
            filteredEvents = []
            for event in firebaseEvents {
                switch filterButton.menu?.selectedElements.first?.title {
                case "Upcoming":
                    if event.title.lowercased().contains(searchText.lowercased()) && event.date > Date() {
                        filteredEvents.append(event)
                    }
                case "Past":
                    if event.title.lowercased().contains(searchText.lowercased()) && event.date < Date() {
                        filteredEvents.append(event)
                    }
                default:
                    print("unknown")
                }
            }
            eventsTable.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    @objc func handleSummaryTap(_ gesture: UITapGestureRecognizer) {
        let summaryViewAlert = UIAlertController(title: "Summary View", message: "Unfortunately this view is still in development", preferredStyle: .alert)
        summaryViewAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(summaryViewAlert, animated: true)
    }
    
    func reloadEventData() {
        return
    }
    
    func notifySuccess() {
        let successAlert = UIAlertController(title: "Success", message: "You have sucessfully made an announcement", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: .default))
        if let hapticPreference = defaults.value(forKey: "hapticPreference") as? Bool {
            if hapticPreference {
                let feedbackGenerator = UINotificationFeedbackGenerator()
                feedbackGenerator.prepare()
                feedbackGenerator.notificationOccurred(.success)
            }
        }
        self.present(successAlert, animated: true)
    }
}

