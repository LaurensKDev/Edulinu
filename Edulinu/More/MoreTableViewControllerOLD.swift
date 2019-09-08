import UIKit

struct HeadlineMore {
    
    var id : Int
    var title : String
    var text : String
    
}

var moreTitleView = ""
var moreLinkView = URL(string: "")
var myIndexMore : Int = 0

class MoreTableViewControllerOLD: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //self.tableView.rowHeight = 70
    }
    
    
    var headlines = [
        HeadlineMore(id: 1, title: "Highlights", text: ""),
        HeadlineMore(id: 2, title: "Klassen", text: ""),
        HeadlineMore(id: 3, title: "Termine", text: ""),
        HeadlineMore(id: 4, title: "Service & Dokumente", text: ""),
        HeadlineMore(id: 5, title: "Datenschutzerklärung", text: ""),
        HeadlineMore(id: 6, title: "Impressum", text: ""),
        HeadlineMore(id: 7, title: "Bug melden", text: ""),
        HeadlineMore(id: 8, title: "Kontakt", text: ""),
        HeadlineMore(id: 9, title: "Namen und Konto zurücksetzen", text: "Damit kannst du deinen App-Namen neu vergeben"),
        ]
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    /*override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Mehr"
    }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath)
        
        let headline = headlines[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = headline.title
        cell.detailTextLabel?.text = headline.text
        
        cell.textLabel?.text = headlines[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        myIndexMore = indexPath.row
        
        
        if myIndexMore == 0
        {
            moreLinkView = URL(string: "https://www.pnms-dobl.at/highlights")
            performSegue(withIdentifier: "moreOpenLinkview", sender: self)
            moreTitleView = "Highlights"
        }
        
        if myIndexMore == 1
        {
            moreLinkView = URL(string: "https://www.pnms-dobl.at/klassen")
            performSegue(withIdentifier: "moreOpenLinkview", sender: self)
            moreTitleView = "Klassen"
        }
        
        if myIndexMore == 2
        {
            moreLinkView = URL(string: "https://www.pnms-dobl.at/termine")
            performSegue(withIdentifier: "moreOpenLinkview", sender: self)
            moreTitleView = "Termine"
        }
        
        if myIndexMore == 3
        {
            moreLinkView = URL(string: "https://www.pnms-dobl.at/service")
            performSegue(withIdentifier: "moreOpenLinkview", sender: self)
            moreTitleView = "Service & Dokumente"
        }
        
        if myIndexMore == 4
        {
            moreLinkView = URL(string: "https://www.laurensk.at/edulinu-app/eapp-datenschutzerklaerung")
            performSegue(withIdentifier: "moreOpenLinkview", sender: self)
            moreTitleView = "Datenschutzerklärung"
        }
        
        if myIndexMore == 5
        {
            moreLinkView = URL(string: "https://www.laurensk.at/edulinu-app/eapp-impressum")
            performSegue(withIdentifier: "moreOpenLinkview", sender: self)
            moreTitleView = "Impressum"
        }
        
        if myIndexMore == 6
        {
            UIApplication.shared.open(URL(string: "mailto:development@laurensk.at")! as URL, options: [:], completionHandler: nil)
        }
        
        if myIndexMore == 7
        {
            
            UIApplication.shared.open(URL(string: "mailto:development@laurensk.at")! as URL, options: [:], completionHandler: nil)
        }
        
        if myIndexMore == 8
        {
            let deleteAlert = UIAlertController(title: "Bist du sicher?", message: "Die Edulinu-App wird zurückgesetzt und kann dann neu eingerichtet werden.", preferredStyle: .alert)
            deleteAlert.addAction(UIAlertAction(title: "App zurücksetzen", style: .destructive, handler: { action in
                
                edulinuLocalUserSettings.set(false, forKey: Keys.wasOnSplashscreen) // With this line you can set the userdefault from wasOnSplashscreen in the whole app.
                edulinuLocalUserSettings.set("No name", forKey: Keys.name)
                
                self.performSegue(withIdentifier: "goToSplashscreen_reset", sender: self)
                
                let alert = UIAlertController(title: "App zurückgesetzt", message: "Die Edulinu-App wurde zurückgesetzt und kann nun neu eingerichtet werden.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Edulinu einrichten", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
            }))
            
            deleteAlert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel, handler: nil))
            self.present(deleteAlert, animated: true)
            
            
        }
        
        
    }
    
    
}

