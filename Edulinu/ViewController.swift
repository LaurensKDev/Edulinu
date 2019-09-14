
//
//  ViewController.swift
//  Edulinu
//
//  Created by Laurens Kropf on 04.03.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit

let localizedWelcomeText = "Willkommen"

class ViewController: UIViewController {
    
    @IBOutlet weak var welcomeTextLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myEdulinuSetup()
        
    }
    
    func myEdulinuSetup() {
        
        welcomeTextLabel.text = localizedWelcomeText + ","
        firstNameLabel.text = edulinuLocalUserSettings.string(forKey: Keys.ElusFirstName)
        
    }
    
}
