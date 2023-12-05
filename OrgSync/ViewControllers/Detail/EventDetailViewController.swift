//
//  EventDetailViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/25/23.
//

import UIKit
import MapKit
import EventKit

class EventDetailViewController: UIViewController {
    
    var eventName = ""
    var eventDate = ""
    var date = Date()
    var eventLocation = ""
    var eventNotes = ""
    var eventCoverImage = UIImage(named: "utaustin")
    
    let eventStore = EKEventStore()
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var whenLabel: UILabel!
    @IBOutlet weak var whereLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    override func viewDidLoad() {
        eventNameLabel.text = eventName
        whenLabel.text = eventDate
        whereLabel.text = eventLocation
        notesLabel.text = eventNotes
        eventImage.image = eventCoverImage
    }
    
    @IBAction func addToCalendarButtonPressed(_ sender: Any) {
        let startDate = date as NSDate
        let endDate = startDate.addingTimeInterval(60*60)
        
        eventStore.requestFullAccessToEvents() {
            (granted, error) in
            if granted {
                self.createEvent(title: self.eventName, startDate: startDate, endDate: endDate)
                self.notifyEventAddSuccess()
            } else {
                print("Error")
            }
        }
    }
    
    func createEvent(title: String, startDate:NSDate, endDate:NSDate) {
        
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate as Date
        event.endDate = endDate as Date
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            print("successfully added")
//            DispatchQueue.main.async {
//                self.eventLabel.text = "Successfully added an event"
//            }
        } catch {
            print("Error")
        }
    }
    
    func notifyEventAddSuccess() {
        let successAlert = UIAlertController(title: "Success", message: "You have sucessfully added this event to your calendar", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: .default))
        if let hapticPreference = defaults.value(forKey: "hapticPreference") as? Bool {
            if hapticPreference {
                let feedbackGenerator = UINotificationFeedbackGenerator()
                feedbackGenerator.prepare()
                feedbackGenerator.notificationOccurred(.success)
            }
        }
        DispatchQueue.main.async {
            self.present(successAlert, animated: true)
        }
    }
}
