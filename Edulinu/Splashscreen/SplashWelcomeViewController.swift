//
//  SplashWelcomeViewController.swift
//  Edulinu
//
//  Created by Laurens on 14.09.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit

class SplashWelcomeViewController: UIViewController {

    @IBAction func SplashToFormVC(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Splashscreen", bundle: nil)
        let splashFormViewController = storyboard.instantiateViewController(withIdentifier: "SplashFormViewController") as! UINavigationController
        splashFormViewController.modalTransitionStyle = .crossDissolve
        self.present(splashFormViewController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
