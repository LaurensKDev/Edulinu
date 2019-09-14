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

    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var detailTextView: UITextView!

    @IBOutlet weak var mailWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

//        checkUserStatus()

    }

//    func checkUserStatus()
//    {
//        statusLabel.isHidden = true
//
//        if edulinuLocalUserSettings.bool(forKey: Keys.isStudent) == true
//        {
//            statusLabel.isHidden = true
//            detailTextView.isHidden = true
//            startMailService()
//        }
//        else if edulinuLocalUserSettings.bool(forKey: Keys.isStudent) == false
//        {
//            statusLabel.text = "Die Mailfunktion ist nur für Schüler verfügbar."
//            detailTextView.text = "Um deinen Benutzerstatus zu ändern, setzte die App bei 'Mehr' zurück."
//            statusLabel.isHidden = false
//            detailTextView.isHidden = false
//        }
//    }
//
//    func startMailService()
//    {
//        let mailURL = URL(string: "https://mail.google.com/mail/mu/mp/71/#tl/Posteingang")
//
//        //self.loginView.addSubview(self.activity)
//        //self.activity.startAnimating()
//        self.mailWebView.navigationDelegate = self
//
//        let request = URLRequest(url: mailURL!)
//        mailWebView.load(request)
//
//    }

}
