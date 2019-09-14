//
//  SplashFormViewController.swift
//  Edulinu
//
//  Created by Laurens on 14.09.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation
import Eureka

class SplashFormViewController: FormViewController {
    
    @IBAction func saveButton(_ sender: Any) {
        
        let formValues = form.values()
        
        if formValues["firstName"] as? String == nil || formValues["lastName"] as? String == nil || formValues["pmsClass"] as? String == nil {
            
            let alert = UIAlertController(title: "Fehler", message: "Bitte fülle alle Felder korrekt aus", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        } else {
            
            let firstName = formValues["firstName"] as! String
            let lastName = formValues["lastName"] as! String
            let pmsClass = formValues["pmsClass"] as! String
            
            if !firstName.isEmpty && !lastName.isEmpty && !pmsClass.isEmpty && pmsClass != "Bitte auswählen" {
                
                if pmsClass == "Ich bin ein Elternteil" {
                    edulinuLocalUserSettings.set("student", forKey: Keys.ElusUserRole)
                } else {
                    edulinuLocalUserSettings.set("parent", forKey: Keys.ElusUserRole)
                }
                
                edulinuLocalUserSettings.set(firstName, forKey: Keys.ElusFirstName)
                edulinuLocalUserSettings.set(lastName, forKey: Keys.ElusLastName)
                edulinuLocalUserSettings.set(pmsClass, forKey: Keys.ElusClass)
                edulinuLocalUserSettings.set(true, forKey: Keys.ElusDidSplash)
                
                let storyboard = UIStoryboard(name: "Splashscreen", bundle: nil)
                let splashGetStartedViewController = storyboard.instantiateViewController(withIdentifier: "SplashGetStartedViewController") as! SplashGetStartedViewController
                splashGetStartedViewController.modalTransitionStyle = .crossDissolve
                self.present(splashGetStartedViewController, animated: true, completion: nil)
                
            } else {
                
                let alert = UIAlertController(title: "Fehler", message: "Bitte fülle alle Felder korrekt aus", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
            }
            
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Über dich"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        form +++ Section("Persönlich")
            
            <<< NameRow(){ row in
                row.title = "Vorname"
                row.placeholder = "Maximilian"
                row.tag = "firstName"
                row.add(rule: RuleRequired())
            }
            
            <<< NameRow(){ row in
                row.title = "Nachname"
                row.placeholder = "Mustermann"
                row.tag = "lastName"
                row.add(rule: RuleRequired())
            }
            
            +++ Section("Schule")
            
            <<< PickerInlineRow<String>(){
                $0.title = "Klasse auswählen"
                $0.options = ["Ich bin ein Elternteil","1A","1B","1C"]
                $0.value = "Bitte auswählen"
                $0.tag = "pmsClass"
                $0.add(rule: RuleRequired())
        }
    }
}
