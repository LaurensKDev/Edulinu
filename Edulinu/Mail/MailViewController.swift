//
//  MailViewController.swift
//  Edulinu
//
//  Created by Laurens Kropf on 27.04.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import WebKit

class MailViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    let mailURL = URL(string: "https://mail.google.com/mail/mu/mp/71/#tl/Posteingang")

    @IBOutlet weak var mailWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if edulinuLocalUserSettings.string(forKey: Keys.ElusUserRole) == "student" {
            
            self.mailWebView.navigationDelegate = self
            let request = URLRequest(url: mailURL!)
            mailWebView.load(request)
            
        } else {
            
            let alert = UIAlertController(title: "Nicht verfügbar", message: "Die Edulinu-Mails sind nur für Schüler verfügbar.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootViewController") as! UITabBarController
                rootViewController.modalTransitionStyle = .crossDissolve
                self.present(rootViewController, animated: true, completion: nil)
                
            }))
            self.present(alert, animated: true)
            
            
            
            
            
        }
        
        


    }

}
