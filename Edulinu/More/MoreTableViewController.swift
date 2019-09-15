//
//  MoreTableViewController.swift
//  Edulinu
//
//  Created by Laurens on 24.08.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import SafariServices
import Firebase

class MoreTableViewController: UITableViewController, SFSafariViewControllerDelegate {
    
    
    struct matchSections {
        let name: String
        let id: Int
        let identifier: String
        let entries: [MoreEntry]
    }
    
    var sections: [matchSections] = []
    
    
    // MARK: Properties
    var moreSections: [MoreSection] = []
    let refMoreSections = Database.database().reference(withPath: "more/moreSections")
    
    var moreEntries: [MoreEntry] = []
    let refMoreEntries = Database.database().reference(withPath: "more/moreEntries")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        refMoreSections.queryOrdered(byChild: "id").observe(.value, with: { snapshot in
            var newMoreSections: [MoreSection] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let moreSection = MoreSection(snapshot: snapshot) {
                    newMoreSections.append(moreSection)
                }
                
            }
            
            self.moreSections = newMoreSections

        })
        
        refMoreEntries.queryOrdered(byChild: "id").observe(.value, with: { snapshot in
            var newMoreEntries: [MoreEntry] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let moreEntry = MoreEntry(snapshot: snapshot) {
                    newMoreEntries.append(moreEntry)
                }
                
            }
            
            self.moreEntries = newMoreEntries
            
            self.sections = self.matchEntries(self.moreSections, self.moreEntries)
            
            self.tableView.reloadData()
            
        })
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }

    // MARK: UITableView Delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath)
        
        let entry = sections[indexPath.section].entries[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator

        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.desc


        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let entry = sections[indexPath.section].entries[indexPath.row]
        
        onClickAction(entry)
        
    }
    
    func matchEntries(_ sectionsToMatch: [MoreSection], _ entriesToMatch: [MoreEntry]) -> [matchSections] {
        
        var matchedSections: [matchSections] = []
        var matchedEntries: [MoreEntry] = []
        
        for section in sectionsToMatch {
            
            for entry in entriesToMatch {
                
                if entry.section == section.identifier {
                
                    matchedEntries.append(MoreEntry(URL: entry.URL, desc: entry.desc, id: entry.id, onClickAction: entry.onClickAction, section: entry.section, title: entry.title))
                    
                    
                }
                
                
            }
            
            
            matchedSections.append(matchSections(name: section.name, id: section.id, identifier: section.identifier, entries: matchedEntries))
            
            matchedEntries = []
            
        }
        
        return matchedSections
        
    }
    
    func onClickAction(_ entry: MoreEntry) {
        
        if entry.onClickAction == "openURL" {
            
            openURL(entry.URL)
            
        } else if entry.onClickAction == "bugReport" {
            
            bugReport()
            
        } else if entry.onClickAction == "updateClass" {
            
            updateClass()
            
        } else if entry.onClickAction == "resetApp" {
            
            resetApp()
            
        } else if entry.onClickAction == "appInfo" {
            
            appInfo()
            
        } else if entry.onClickAction == "openMail" {
            
            openMail(entry.URL)
            
        } else {
            
            onClickActionNotAvailable()
            
        }
        
    }
    
    func openURL(_ urlString: String) {
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        }
        
    }
    
    func bugReport() {
        
        UIApplication.shared.open(URL(string: "mailto:development@edulinu.com")! as URL, options: [:], completionHandler: nil)
        
    }
    
    func updateClass() {
        
        let storyboard = UIStoryboard(name: "UpdateClass", bundle: nil)
        let updateClassFormViewController = storyboard.instantiateViewController(withIdentifier: "UpdateClassFormViewController") as! UINavigationController
        self.present(updateClassFormViewController, animated: true, completion: nil)
        
    }
    
    func resetApp() {
        
        let deleteAlert = UIAlertController(title: "Bist du sicher?", message: "Die Edulinu-App wird zurückgesetzt und kann dann neu eingerichtet werden.", preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: "App zurücksetzen", style: .destructive, handler: { action in

            edulinuLocalUserSettings.set(false, forKey: Keys.ElusDidSplash)
            edulinuLocalUserSettings.set("noFirstName", forKey: Keys.ElusFirstName)
            edulinuLocalUserSettings.set("noLastName", forKey: Keys.ElusLastName)
            edulinuLocalUserSettings.set("noClass", forKey: Keys.ElusClass)
            edulinuLocalUserSettings.set(true, forKey: Keys.ElusHasAgreedToSentStatistics)
            edulinuLocalUserSettings.set([""], forKey: Keys.ElusFavouriteTeachers)

            let storyboard = UIStoryboard(name: "Splashscreen", bundle: nil)
            let splashWelcomeViewController = storyboard.instantiateViewController(withIdentifier: "SplashWelcomeViewController") as! SplashWelcomeViewController
            self.present(splashWelcomeViewController, animated: true, completion: nil)

        }))

        deleteAlert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel, handler: nil))
        self.present(deleteAlert, animated: true)
        
    }
    
    func appInfo() {
        
        performSegue(withIdentifier: "appInfo", sender: self)
        
    }
    
    func openMail(_ mailString: String) {
        
        UIApplication.shared.open(URL(string: mailString)! as URL, options: [:], completionHandler: nil)
        
    }
    
    func onClickActionNotAvailable() {
        
        let UpdateAppAlert = UIAlertController(title: "App-Version veraltet", message: "Bitte aktualisiere die Edulinu-App im App Store, um diese Funktion nutzen zu können.", preferredStyle: .alert)
        
        UpdateAppAlert.addAction(UIAlertAction(title: "Zum App Store", style: .default, handler: { action in
            
            UIApplication.shared.open(URL(string: "itms-apps://?action=updates")! as URL, options: [:], completionHandler: nil)
            
        }))
        
        UpdateAppAlert.addAction(UIAlertAction(title: "Schließen", style: .cancel, handler: nil))
        
        self.present(UpdateAppAlert, animated: true)
        
    }
        
}
