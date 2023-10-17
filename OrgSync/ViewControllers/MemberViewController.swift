//
//  MemberViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit
import Firebase

let members = [Member(firstName: "Hank", lastName: "Hayes", dob: "09/27/2001", classification: 3, role: "Member", phone:"9155431072", email:"hankhayes@utexas.edu"), Member(firstName: "Elisa", lastName: "Baxter", dob: "08/07/2001", classification: 4, role: "Pledge Trainer", phone:"1529962058", email:"elisa.baxter@gmail.com"), Member(firstName: "Milan", lastName: "Patel", dob: "09/01/01", classification: 3, role: "Social", phone:"5125820924", email:"milan.patel@utexas.edu")]

class MemberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let memberCellIdentifier = "MemberCell"
    let detailSegueIdentifier = "memberToMemberDetail"
    private let ref = Database.database().reference().child("users")
    
    @IBOutlet weak var titleBackground: UIView!
    @IBOutlet weak var memberTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        memberTable.delegate = self
        memberTable.dataSource = self
        titleBackground.layer.cornerRadius = 20
        
        ref.observe(.value, with: {(snapshot) in
            print(snapshot.value as Any)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if memberTable.indexPathForSelectedRow != nil {
            memberTable.deselectRow(at: memberTable.indexPathForSelectedRow!, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return members.count
    }
    
    func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memberTable.dequeueReusableCell(withIdentifier: memberCellIdentifier, for: indexPath as IndexPath) as! MemberCell
        let row = indexPath.row
        
        cell.nameLabel.text = "\(members[row].firstName) \(members[row].lastName)"
        cell.classLabel.text = String(members[row].classification)
        cell.roleLabel.text = members[row].role
        
        switch members[row].classification {
        case 0:
            cell.classLabel.text = "Freshman"
        case 1:
            cell.classLabel.text = "Sophomore"
        case 2:
            cell.classLabel.text = "Junior"
        case 3:
            cell.classLabel.text = "Senior"
        case 4:
            cell.classLabel.text = "Super Senior"
        default:
            cell.classLabel.text = "Unkown"
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier,
           let destination = segue.destination as? MemberDetailViewController,
           let memberIndex = memberTable.indexPathForSelectedRow?.row {
            destination.firstName = members[memberIndex].firstName
            destination.lastName = members[memberIndex].lastName
            destination.birthday = members[memberIndex].dob
            destination.classification = members[memberIndex].classification
            destination.role = members[memberIndex].role
            destination.phone = members[memberIndex].phone
            destination.email = members[memberIndex].email
            destination.image = UIImage(named: "hank")
            
        }
    }
}
