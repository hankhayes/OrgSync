//
//  CreateAnnouncementViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/1/23.
//

import UIKit
import Firebase

class CreateAnnouncementViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var subjectField: UITextField!
    @IBOutlet weak var bodyField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var tagPicker: UIPickerView!
    
    
    
    let data = ["General", "Social", "Philanthropy", "Finance"]
    var selectedTag = "general"
    
    private let ref = Database.database().reference().child("announcements")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.borderWidth = 2
        submitButton.layer.cornerRadius = 10
        submitButton.layer.borderColor = UIColor(named: "burntorange")?.cgColor
        
        tagPicker.delegate = self
        tagPicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedOption = data[row]
            
        switch selectedOption {
        case "General":
            selectedTag = "general"
        case "Social":
            selectedTag = "social"
        case "Philanthropy":
            selectedTag = "philanthropy"
        case "Finance":
            selectedTag = "finance"
        default:
            selectedTag = "general"
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        let date = Date()
        let announcementID = UUID().uuidString
        
        let newFirebaseAnnouncement = [
            "announcementID": announcementID,
            "subject": subjectField.text!,
            "body": bodyField.text!,
            "date": date.timeIntervalSince1970,
            "announcer": "\(currentUser.firstName) \(currentUser.lastName)",
            "tag": selectedTag
        ] as [String: Any]
        
        let newItemRef = self.ref.child(announcementID)
        
        newItemRef.setValue(newFirebaseAnnouncement)
        
    }
}
