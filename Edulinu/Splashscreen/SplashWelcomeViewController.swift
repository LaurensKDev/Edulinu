//
//  SplashWelcomeViewController.swift
//  Edulinu
//
//  Created by Laurens on 14.09.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit

class SplashWelcomeViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    
    @IBAction func SplashToFormVC(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Splashscreen", bundle: nil)
        let splashFormViewController = storyboard.instantiateViewController(withIdentifier: "SplashFormViewController") as! UINavigationController
        splashFormViewController.modalTransitionStyle = .crossDissolve
        splashFormViewController.modalPresentationStyle = .fullScreen
        presentWithSlide(splashFormViewController)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.userInterfaceStyle == .dark {
            self.view.backgroundColor = UIColor.black
            textField.textColor = UIColor.white
        } else {
            self.view.backgroundColor = UIColor.white
            textField.textColor = UIColor.black
        }

        // Do any additional setup after loading the view.
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if userInterfaceStyle == .dark {
            self.view.backgroundColor = UIColor.black
            textField.textColor = UIColor.white
        } else {
            self.view.backgroundColor = UIColor.white
            textField.textColor = UIColor.black
        }
    }

}
