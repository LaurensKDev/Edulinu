
//
//  ViewController.swift
//  Edulinu
//
//  Created by Laurens Kropf on 04.03.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

let localizedWelcomeText = "Willkommen"

class ViewController: UIViewController {
    
    @IBOutlet weak var welcomeTextLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //userdefaults.set(false, forKey: Keys.wasOnSplashscreen) // With this line you can set the userdefault from wasOnSplashscreen in the whole app.
        
        checkForSplashscreen()
        
        myEdulinuSetup()
        
    }
    
 
    func checkForSplashscreen() {
        let wasOnSplashscreen = edulinuLocalUserSettings.bool(forKey: Keys.wasOnSplashscreen)
        
        if wasOnSplashscreen == false {
            
            DispatchQueue.main.async(){
                self.performSegue(withIdentifier: "goToSplashscreen", sender: self)
            }
            
        } else {
            
        }
    }
    
    func myEdulinuSetup() {
        
        welcomeTextLabel.text = localizedWelcomeText + ","
        firstNameLabel.text = edulinuLocalUserSettings.string(forKey: Keys.name)
        
    }
    
    
    
}
