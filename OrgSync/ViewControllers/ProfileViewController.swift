//
//  ProfileViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 10/1/23.
//

import UIKit
import Firebase
import CoreMotion
import CoreGraphics

protocol FirebaseNameUpdater {
    func updateName()
}

class ProfileViewController: UIViewController, FirebaseNameUpdater {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var membershipCard: UIView!
    
    @IBOutlet weak var logoBackground: UIView!
    
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
        updateName()
    }
    
    func updateName() {
        firstNameLabel.text = currentUser.firstName
        lastNameLabel.text = currentUser.lastName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditProfile",
           let nextVC = segue.destination as? EditProfileViewController {
            nextVC.delegate = self
        }
    }
}
