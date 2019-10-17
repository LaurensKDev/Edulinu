//
//  NewsNotificationViewController.swift
//  Edulinu
//
//  Created by Laurens on 15.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import Firebase
import OneSignal

class NewsNotificationViewController: UIViewController {

    var newsEntry: News?
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsTextTextView: UITextView!
    
    @IBAction func dismissButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        newsTitleLabel?.text = newsEntry?.title
        newsAuthorLabel?.text = newsEntry?.author
        newsTextTextView?.text = newsEntry?.text
        
    }

}
