//
//  MemberViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 9/24/23.
//

import UIKit
import Firebase

class MemberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, UISearchBarDelegate {
    
    // Identifiers
    let memberCellIdentifier = "MemberCell"
    let detailSegueIdentifier = "memberToMemberDetail"
    
    // Database reference
    private let ref = Database.database().reference().child("users")
    
    // Stores all members
    var firebaseMembers = [Member]()
    // Stores members that are currently being shown
    var filteredMembers = [Member]()
    
    // IB Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var memberTable: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates
        memberTable.delegate = self
        memberTable.dataSource = self
        searchBar.delegate = self

        // Creates the filter menu
        let filterMenu = UIMenu(title: "Filter by", options: [.singleSelection, .displayInline], children: [
            
            // Creates the ALL filter
            UIAction(title: "All", state: .on, handler: {_ in
                self.filteredMembers = []
                for member in self.firebaseMembers {
                    self.filteredMembers.append(member)
                }
                self.filteredMembers.sort()
                // Reloads the table data after ALL is selected
                self.memberTable.reloadData()
            }),
            
            // Creates the ACTIVE MEMBERS filter
            UIAction(title: "Active members", handler: {_ in
                self.filteredMembers = []
                for member in self.firebaseMembers {
                    if member.classification < 4 {
                        self.filteredMembers.append(member)
                    }
                }
                self.filteredMembers.sort()
                // Reloads the table data after ACTIVE MEMBERS is selected
                self.memberTable.reloadData()
            }),
            
            // Creates the ALUMNI filter
            UIAction(title: "Alumni", handler: {_ in
                self.filteredMembers = []
                for member in self.firebaseMembers {
                    if member.classification > 3 {
                        self.filteredMembers.append(member)
                    }
                }
                self.filteredMembers.sort()
                // Reloads the table data after ALUMNI is selected
                self.memberTable.reloadData()
            })
        ])
        
        // Creates the mainMenu
        let mainMenu = UIMenu(children: [
            filterMenu
        ])
        
        // Adds the menu to the filterButton
        filterButton.menu = mainMenu
        
        // Calls fetchFirebaseMembers
        fetchFirebaseMembers()
        
        // Creates refresh functionality
        memberTable.refreshControl = UIRefreshControl()
        memberTable.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
        
        // Dismisses the keyboard on dragging memberTable
        memberTable.keyboardDismissMode = .onDrag
    }
    
    // Called when memberTable is refreshed by a pull gesture
    @objc func callPullToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.memberTable.refreshControl?.endRefreshing()
            self.fetchFirebaseMembers()
            self.memberTable.reloadData()
        }
    }
    
    // Fetches all members stored in Firebase
    func fetchFirebaseMembers() {
        // Clears both member arrays
        firebaseMembers.removeAll()
        filteredMembers.removeAll()
        
        // Observes Firebase Database
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            // Iterates through every member in Firebase
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let childData = childSnapshot.value as? [String: Any],
                   let fbFirstName = childData["firstName"] as? String,
                   let fbLastName = childData["lastName"] as? String,
                   let fbBirthday = childData["birthday"] as? Int,
                   let fbPhone = childData["phone"] as? Int,
                   let fbEmail = childData["email"] as? String,
                   let fbRole = childData["role"] as? String,
                   let fbClassification = childData["classification"] as? Int {
                    // Creates a firebaseMember
                    let firebaseMember = Member(firstName: fbFirstName, lastName: fbLastName, birthday: fbBirthday, classification: fbClassification, role: fbRole, phone: fbPhone, email: fbEmail)
                    
                    // Adds firebaseMember to firebaseMembers
                    self.firebaseMembers.append(firebaseMember)
                    
                    // Adds firebaseMember only if they are part of the current filter group
                    switch self.filterButton.menu?.selectedElements.first?.title {
                    case "All":
                        self.filteredMembers.append(firebaseMember)
                    case "Active members":
                        if firebaseMember.classification < 4 {
                            self.filteredMembers.append(firebaseMember)
                        }
                    case "Alumni":
                        if firebaseMember.classification > 3 {
                            self.filteredMembers.append(firebaseMember)
                        }
                    default:
                        print("unknown")
                    }
                }
            }
            // Reloads memberTable
            self.filteredMembers.sort()
            self.memberTable.reloadData()
        })
    }
    
    // ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        // Deselects any selected rows
        if memberTable.indexPathForSelectedRow != nil {
            memberTable.deselectRow(at: memberTable.indexPathForSelectedRow!, animated: false)
        }
    }
    
    // Returns count of filteredMembers
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return filteredMembers.count
    }
    
    // Returns the height of each custom cell
    func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memberTable.dequeueReusableCell(withIdentifier: memberCellIdentifier, for: indexPath as IndexPath) as! MemberCell
        let row = indexPath.row
        
        cell.nameLabel.text = "\(filteredMembers[row].firstName) \(filteredMembers[row].lastName)"
        cell.classLabel.text = String(filteredMembers[row].classification)
        cell.roleLabel.text = filteredMembers[row].role
        
        switch filteredMembers[row].classification {
        case 0:
            cell.classLabel.text = "Freshman"
        case 1:
            cell.classLabel.text = "Sophomore"
        case 2:
            cell.classLabel.text = "Junior"
        case 3:
            cell.classLabel.text = "Senior"
        default:
            cell.classLabel.text = "Alumni"
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier,
           let destination = segue.destination as? MemberDetailViewController,
           let memberIndex = memberTable.indexPathForSelectedRow?.row {
            destination.firstName = filteredMembers[memberIndex].firstName
            destination.lastName = filteredMembers[memberIndex].lastName
            destination.birthday = filteredMembers[memberIndex].birthday
            destination.classification = filteredMembers[memberIndex].classification
            destination.role = filteredMembers[memberIndex].role
            destination.phone = filteredMembers[memberIndex].phone
            destination.email = filteredMembers[memberIndex].email
            destination.image = UIImage(named: "hank")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredMembers = []
            for member in firebaseMembers {
                switch filterButton.menu?.selectedElements.first?.title {
                case "All":
                    filteredMembers.append(member)
                case "Active members":
                    if member.classification < 4 {
                        filteredMembers.append(member)
                    }
                case "Alumni":
                    if member.classification > 3 {
                        filteredMembers.append(member)
                    }
                default:
                    print("unknown")
                }
            }
            memberTable.reloadData()
        } else {
            filteredMembers = []
            for member in firebaseMembers {
                switch filterButton.menu?.selectedElements.first?.title {
                case "All":
                    if member.firstName.lowercased().contains(searchText.lowercased()) {
                        filteredMembers.append(member)
                    }
                case "Active members":
                    if member.firstName.lowercased().contains(searchText.lowercased()) && member.classification < 4 {
                        filteredMembers.append(member)
                    }
                case "Alumni":
                    if member.firstName.lowercased().contains(searchText.lowercased()) && member.classification > 3 {
                        filteredMembers.append(member)
                    }
                default:
                    print("unknown")
                }
            }
            memberTable.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
