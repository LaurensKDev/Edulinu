//
//  SplashGetStartedViewController.swift
//  Edulinu
//
//  Created by Laurens Kropf on 26.04.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit

class SplashGetStartedViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    
    @IBOutlet weak var welcomeMessageLabel: UILabel!
    
    @IBAction func startAppButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootViewController") as! UITabBarController
        rootViewController.modalTransitionStyle = .crossDissolve
        rootViewController.modalPresentationStyle = .fullScreen
        self.present(rootViewController, animated: true, completion: nil)
        

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.userInterfaceStyle == .dark {
            self.view.backgroundColor = UIColor.black
            textField.textColor = UIColor.white
        } else {
            self.view.backgroundColor = UIColor.white
            textField.textColor = UIColor.black
        }
        
        welcomeMessageLabel.text = "Hallo, \(edulinuLocalUserSettings.string(forKey: Keys.ElusFirstName) ?? "No name")!"
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if userInterfaceStyle == .dark {
            self.view.backgroundColor = UIColor.black
            textField.textColor = UIColor.white
        } else {
            self.view.backgroundColor = UIColor.white
            textField.textColor = UIColor.black
        }
    }
    


}
