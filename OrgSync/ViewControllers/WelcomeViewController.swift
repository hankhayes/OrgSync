//
//  WelcomeViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 11/2/23.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let abstractBackground = welcomeDrawing(frame: view.bounds)
//        abstractBackground.backgroundColor = .clear
//        view.addSubview(abstractBackground)
        // This code automaticall logs you in if you have previously logged in
        Auth.auth().addStateDidChangeListener() {
            (auth,user) in
            if user != nil {
                
                self.fillInCurrentUser()
                
                let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCTabBar")
                destinationVC?.modalPresentationStyle = .fullScreen
                self.present(destinationVC!, animated: true)
            }
        }
        
        // Title label style
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(named: "text")?.cgColor, UIColor.lightGray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = titleView.bounds
        
        view.addSubview(titleLabel)
        
        titleView.layer.addSublayer(gradientLayer)
        titleView.mask = titleLabel
        titleView.alpha = 0
        
        // Button styling
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        loginButton.backgroundColor = UIColor(named: "moduleBackground")
        
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        signUpButton.backgroundColor = UIColor(named: "moduleBackground")
        
        UIView.animate(withDuration: 1.5, animations: {
            self.titleView.alpha = 1.0
        })
        
        drawRadialGradients()
        
        UIView.animate(withDuration: 1.5, animations: {
            self.backgroundView.alpha = 1.0
        })
    }
    
    func fillInCurrentUser() {
        let ref = Database.database().reference(withPath: "users")
        let currentUID = Auth.auth().currentUser!.uid
        let userRef = ref.child("\(currentUID)")
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? [String: Any] {
                print(value["firstName"] as! String)
                currentUser.firstName = value["firstName"] as! String
                currentUser.lastName = value["lastName"] as! String
                currentUser.birthday = value["birthday"] as! Int
                currentUser.classification = value["classification"] as! Int
                currentUser.role = value["role"] as! String
                currentUser.phone = value["phone"] as! Int
                currentUser.email = value["email"] as! String
            }
        }
        print("filled in current user")
    }
    
    func drawRadialGradients() {
        let gradient = CAGradientLayer()
        let colors = [UIColor(named: "myIndigo")?.cgColor, UIColor.clear.cgColor]
    
        gradient.colors = colors
        gradient.type = .radial
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0, y: 250, width: 300, height: 300)
        
        let gradient2 = CAGradientLayer()
        let colors2 = [UIColor.systemIndigo.cgColor, UIColor.clear.cgColor]
    
        gradient2.colors = colors2
        gradient2.type = .radial
        gradient2.locations = [0.0, 1.0]
        gradient2.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient2.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient2.frame = CGRect(x: 50, y: 300, width: 400, height: 400)
        
        backgroundView.layer.addSublayer(gradient)
        backgroundView.layer.addSublayer(gradient2)
        
        let blur = UIVisualEffectView(effect:UIBlurEffect(style: .regular))
        blur.frame = backgroundView.bounds

        backgroundView.addSubview(blur)
        backgroundView.alpha = 0
    }
}

