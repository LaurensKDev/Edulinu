//
//  SplashGetStartedViewController.swift
//  Edulinu
//
//  Created by Laurens Kropf on 26.04.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit

class SplashGetStartedViewController: UIViewController {

    
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
        
        welcomeMessageLabel.text = "Hallo, \(edulinuLocalUserSettings.string(forKey: Keys.ElusFirstName) ?? "No name")!"
        
    }
    


}
