//
//  UpdateClassViewController.swift
//  Edulinu
//
//  Created by Laurens on 14.09.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import Eureka

class UpdateClassFormViewController: FormViewController {

    @IBAction func dismissButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let formValues = form.values()
        
        if formValues["pmsClass"] as? String == nil {
            
            let alert = UIAlertController(title: "Klasse auswählen", message: "Bitte wähle eine Klasse aus", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        } else {
            
            let pmsClass = formValues["pmsClass"] as! String
            
            if pmsClass != "Bitte auswählen" {
                
                edulinuLocalUserSettings.set(pmsClass, forKey: Keys.ElusClass)
                edulinuLocalUserSettings.set(Date(), forKey: Keys.ElusClassLastUpdateDate)
                
                self.dismiss(animated: true, completion: nil)
                
            } else {
                
                let alert = UIAlertController(title: "Klasse auswählen", message: "Bitte wähle eine Klasse aus", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Klasse ändern"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        form +++ Section(header: "Klasse auswählen", footer: "Willkommen im neuen Schuljahr! Bitte wähle deine neue Klasse aus, um die App wieder im vollen Umfang nutzen zu können.")
            
            <<< PickerRow<String>(){
                $0.title = "Klasse auswählen"
                $0.options = ["Bitte auswählen","1A","1B","1C","1D","2A","2B","2C","2D","3A","3B","3C","3D","4A","4B","4C","4D"]
                $0.value = "Bitte auswählen"
                $0.tag = "pmsClass"
                $0.add(rule: RuleRequired())
        }

    }

}
