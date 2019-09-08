//
//  WelcomeNameViewController.swift
//  Edulinu
//
//  Created by Laurens Kropf on 26.04.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit

class WelcomeNameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func nextButton(_ sender: Any) {
        
        self.view.endEditing(true)
        
        let name = nameTextField.text!
        
        if name.isName
        {
            edulinuLocalUserSettings.set(name, forKey: Keys.name)
            
            DispatchQueue.main.async(){
                self.performSegue(withIdentifier: "goToLogin", sender: self)
            }
            
            print(edulinuLocalUserSettings.string(forKey: Keys.name) ?? "No name") // only for debugging -  prints out the name from the userdefaults
        } else
        {
            let alert = UIAlertController(title: "Ungültige Eingabe", message: "Bitte gib deinen vollständigen Namen ein", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Schließen", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension String {
    var isName: Bool {
        return !isEmpty && range(of: "[^a-zA-Z ]", options: .regularExpression) == nil
    }
}
