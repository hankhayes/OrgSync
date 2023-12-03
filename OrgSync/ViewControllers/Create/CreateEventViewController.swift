//
//  CreateEventViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/1/23.
//

import UIKit
import Firebase

class CreateEventViewController: UIViewController {
    
    var formIsComplete = true
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private let ref = Database.database().reference().child("events")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.borderWidth = 2
        submitButton.layer.cornerRadius = 10
        submitButton.layer.borderColor = UIColor(named: "burntorange")?.cgColor
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        let inputDate = datePicker.date
        
        let eventID = UUID().uuidString
        
        let newFirebaseEvent = [
            "eventID": eventID,
            "title": nameField.text!,
            "date": inputDate.timeIntervalSince1970,
            "notes": notesField.text!,
            "location": locationField.text!
        ] as [String : Any]
        
        let newItemRef = self.ref.child(eventID)
        
        newItemRef.setValue(newFirebaseEvent)
    }
}
