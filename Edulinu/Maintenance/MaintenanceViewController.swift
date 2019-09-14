//
//  MaintenanceViewController.swift
//  Edulinu
//
//  Created by Laurens on 14.09.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import Firebase

class MaintenanceViewController: UIViewController {

    @IBOutlet weak var maintenanceTitleLabel: UILabel!
    
    @IBOutlet weak var maintenanceMessageLabel: UITextView!
    
    // MARK: Properties
    
    let ref = Database.database().reference(withPath: "maintenance")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        maintenanceTitleLabel.textColor = .white
        maintenanceMessageLabel.backgroundColor = .black
        maintenanceMessageLabel.textColor = .white
        
        
        ref.observe(.value, with: { (snapshot) in
            if let value = snapshot.value as? [String: Any] {
                let maintenanceMessage = value["maintenanceMessage"] as? String ?? ""
                let maintenanceMode = value["maintenanceMode"] as? Bool ?? false
                let maintenanceTitle = value["maintenanceTitle"] as? String ?? ""
                
                self.maintenanceTitleLabel.text = maintenanceTitle
                self.maintenanceMessageLabel.text = maintenanceMessage
                
                if maintenanceMode == false {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootViewController")
                    self.present(rootViewController, animated: false, completion: nil)
                    
                }
                
            }
        })
        
    }


}
