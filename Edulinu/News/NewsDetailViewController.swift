//
//  NewsDetailViewController.swift
//  Edulinu
//
//  Created by Laurens on 15.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    var newsEntry: News? {
        didSet {
            print(newsEntry?.title)
        }
    }

    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAutherLabel: UILabel!
    @IBOutlet weak var newsTextTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        newsTitleLabel?.text = newsEntry?.title
        newsAutherLabel?.text = newsEntry?.author
        newsTextTextView?.text = newsEntry?.text
        
    }
    

}
