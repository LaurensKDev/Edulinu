//
//  WelcomeFinishViewController.swift
//  Edulinu
//
//  Created by Laurens Kropf on 26.04.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit

class WelcomeFinishViewController: UIViewController {

    @IBOutlet weak var welcomeMessage: UILabel!
    
    @IBAction func letsGoButton(_ sender: Any) {
        
        edulinuLocalUserSettings.set(true, forKey: Keys.wasOnSplashscreen) // With this line you can set the userdefault from wasOnSplashscreen in the whole app.
        
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "goToApp", sender: self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        welcomeMessage.text = "Hallo, \(edulinuLocalUserSettings.string(forKey: Keys.name) ?? "No name")!"
    }
    


}
