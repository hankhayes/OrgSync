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
    
    var delegate = UIViewController()
    
    private let ref = Database.database().reference().child("events")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        submitButton.layer.cornerRadius = 10
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        let inputDate = datePicker.date
        
        let eventID = UUID().uuidString
        
        let eventVC = delegate as! SuccessNotifier
        
        let newFirebaseEvent = [
            "eventID": eventID,
            "title": nameField.text!,
            "date": inputDate.timeIntervalSince1970,
            "notes": notesField.text!,
            "location": locationField.text!
        ] as [String : Any]
        
        let newItemRef = self.ref.child(eventID)
        
        newItemRef.setValue(newFirebaseEvent)
        
        self.dismiss(animated: true) {
            eventVC.notifySuccess()
        }
    }
}
