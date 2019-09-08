//
//  WelcomeLoginViewController.swift
//  Edulinu
//
//  Created by Laurens Kropf on 26.04.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

class WelcomeLoginViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var loginView: WKWebView!
    
    @IBAction func doneButton(_ sender: Any) {
        
        edulinuLocalUserSettings.set(true, forKey: Keys.isStudent)
        
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "goToFinishscreen", sender: self)
        }
        
    }
    
    @IBAction func parentButton(_ sender: Any) {
        
        edulinuLocalUserSettings.set(false, forKey: Keys.isStudent)
        
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "goToFinishscreen", sender: self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loginURL = URL(string: "https://sites.google.com/edulinu.com/app-login/startseite")
        
        //self.loginView.addSubview(self.activity)
        //self.activity.startAnimating()
        self.loginView.navigationDelegate = self
        
        let request = URLRequest(url: loginURL!)
        loginView.load(request)
        
        // Do any additional setup after loading the view.
    }
    


}
