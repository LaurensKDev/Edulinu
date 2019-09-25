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
    
    let mailActivityIndicator = UIActivityIndicatorView(style: .gray)
    
    let mailURL = URL(string: "https://mail.google.com/mail/mu/mp/71/#tl/Posteingang")

    @IBOutlet weak var mailWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailActivityIndicator.hidesWhenStopped = true
        mailActivityIndicator.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mailActivityIndicator)
        
        self.view.addSubview(mailActivityIndicator)

        self.view.addSubview(self.mailWebView)
        
        if edulinuLocalUserSettings.string(forKey: Keys.ElusUserRole) == "student" {
            
            self.mailWebView.navigationDelegate = self
            let request = URLRequest(url: mailURL!)
            mailWebView.load(request)
            
            //activity indicator
            self.mailWebView.addSubview(mailActivityIndicator)
            self.mailActivityIndicator.startAnimating()
            self.mailWebView.navigationDelegate = self
            self.mailActivityIndicator.hidesWhenStopped = true
            
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
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        mailActivityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        mailActivityIndicator.stopAnimating()
    }

}
