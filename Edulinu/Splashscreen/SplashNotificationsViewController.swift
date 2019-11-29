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
                
                let firstName = edulinuLocalUserSettings.string(forKey: Keys.ElusFirstName) ?? ""
                let lastName = edulinuLocalUserSettings.string(forKey: Keys.ElusLastName) ?? ""
                let userRole = edulinuLocalUserSettings.string(forKey: Keys.ElusUserRole) ?? ""
                let pmsClass = edulinuLocalUserSettings.string(forKey: Keys.ElusClass) ?? ""
                
                let oneSignalTagsDict: [String: String] = ["firstName": firstName, "lastName": lastName, "userRole": userRole, "pmsClass": pmsClass, "platform": "iOS"]
                OneSignal.sendTags(oneSignalTagsDict)
                
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
