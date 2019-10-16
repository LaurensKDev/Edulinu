//
//  SplashNotificationsViewController.swift
//  Edulinu
//
//  Created by Laurens on 16.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import OneSignal

class SplashNotificationsViewController: UIViewController {

    @IBAction func askForPushPermissionButton(_ sender: Any) {
        
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            if accepted {
                
                let storyboard = UIStoryboard(name: "Splashscreen", bundle: nil)
                let splashGetStartedViewController = storyboard.instantiateViewController(withIdentifier: "SplashGetStartedViewController") as! SplashGetStartedViewController
                splashGetStartedViewController.modalTransitionStyle = .crossDissolve
                splashGetStartedViewController.modalPresentationStyle = .fullScreen
                self.presentWithSlide(splashGetStartedViewController)
                
            } else {
                
                let alert = UIAlertController(title: "Schade", message: "Falls du doch Benachrichtigungen erhalten möchtest, kannst du den Schalter für Edulinu in den Einstellungen unter Mitteilungen aktivieren.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Weiter", style: .cancel, handler: { action in
                    
                    let storyboard = UIStoryboard(name: "Splashscreen", bundle: nil)
                    let splashGetStartedViewController = storyboard.instantiateViewController(withIdentifier: "SplashGetStartedViewController") as! SplashGetStartedViewController
                    splashGetStartedViewController.modalTransitionStyle = .crossDissolve
                    splashGetStartedViewController.modalPresentationStyle = .fullScreen
                    self.presentWithSlide(splashGetStartedViewController)
                    
                }))
                self.present(alert, animated: true)
                
                
                
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
