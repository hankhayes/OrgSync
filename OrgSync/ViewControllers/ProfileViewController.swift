//
//  ProfileViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/1/23.
//

import UIKit
import Firebase
import CoreMotion

protocol FirebaseNameUpdater {
    func updateName()
}

class ProfileViewController: UIViewController, FirebaseNameUpdater {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var membershipCard: UIView!
    
    @IBOutlet weak var animatedCard: UIView!
    @IBOutlet weak var hapticButton: UIButton!
    
    let motionManager = CMMotionManager()
    let defaults = UserDefaults.standard
    
    var locations = [NSNumber]()
    
    
    let currentUID = Auth.auth().currentUser!.uid
    let ref = Database.database().reference(withPath: "users")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        membershipCard.layer.cornerRadius = 20
        updateCardColor()
        updateName()
        
    }
    
    func updateCardColor() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
                if let motionData = motionData {
                    // Process motion data here
                    // Calculate color based on the motion data
                    // Update the UIView's color
                    let roll = motionData.attitude.roll
                    // let pitch = motionData.attitude.pitch
                    // let yaw = motionData.attitude.yaw
                    
                    let gradientLayer = CAGradientLayer()
                    
                    let change = abs(0.5 + CGFloat(roll / 6.0)) as NSNumber
                    
                    gradientLayer.locations = [0.0, change, 1.0]
                    
                    gradientLayer.colors = [UIColor.systemIndigo.cgColor, UIColor.white.cgColor, UIColor.systemIndigo.cgColor]
                    
                    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
                    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
                    
                    gradientLayer.frame = self.membershipCard.bounds
                    gradientLayer.cornerRadius = 20.0
                    
                    // self.membershipCard.layer.insertSublayer(gradientLayer, at: 0)
                    self.membershipCard.layer.addSublayer(gradientLayer)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Profile will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Profile appeared")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Profile DISappeared")
    }
    
    func updateName() {
        print("updating name...")
        // firstNameLabel.text = currentUser.firstName
        // lastNameLabel.text = currentUser.lastName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditProfile",
           let nextVC = segue.destination as? EditProfileViewController {
            nextVC.delegate = self
        }
    }
    
    @IBAction func hapticButtonPressed(_ sender: Any) {
        if let hapticPreference = defaults.value(forKey: "hapticPreference") as? Bool {
            if hapticPreference {
                let feedbackGenerator = UINotificationFeedbackGenerator()
                feedbackGenerator.prepare()
                feedbackGenerator.notificationOccurred(.success)
            }
        }
        updateName()
    }
    
    @IBAction func iconButton(_ sender: Any) {
        UIApplication.shared.setAlternateIconName("orgsync-reverse") { (error) in
            if let error = error {
                print("Failed request to update the app’s icon: \(error)")
            }
        }
    }
}
