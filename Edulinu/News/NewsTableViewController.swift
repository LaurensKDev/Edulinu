//
//  NewsTableViewController.swift
//  Edulinu
//
//  Created by Laurens on 15.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import Firebase

class NewsTableViewController: UITableViewController {
    
    // MARK: Properties
    var news: [News] = []
    
    let ref = Database.database().reference(withPath: "news")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .always
        
        ref.queryOrdered(byChild: "newsId").observe(.value, with: { snapshot in
            var newNews: [News] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let newsEntry = News(snapshot: snapshot) {
                    newNews.append(newsEntry)
                }
                
            }
            
            self.news = newNews
            self.news.sort { $1.newsId < $0.newsId }
            
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        let newsEntry = news[indexPath.row]
        
        cell.newsTitleLabel!.text = newsEntry.title
        cell.newsDescTextView!.text = newsEntry.desc
        cell.newsImageView?.sd_setImage(with: URL(string: newsEntry.imageUrl), placeholderImage: UIImage(named: "loading214x322_white"), options: [])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // Transition to NewsDetailViewController with storyboard segue in Main.storyboard
        tableView.deselectRow(at: indexPath, animated: true)
        
        let newsEntryToPass = news[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if  let newsDetailViewController = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController {
            newsDetailViewController.newsEntry = newsEntryToPass
            //self.present(newsDetailViewController, animated: true, completion: nil)
            //self.showDetailViewController(self, sender: newsDetailViewController)
            self.navigationController?.pushViewController(newsDetailViewController, animated: true)
        }
        
        

//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let newsDetailViewController = storyboard.instantiateViewController(withIdentifier: "NewsDetailTableViewController") as! NewsDetailViewController
//
//        guard let newsDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailTableViewController") else { return }
//        let navController = UINavigationController(rootViewController: newsDetailVC)
//
//
//
//
//        newsDetailViewController.modalTransitionStyle = .crossDissolve
//        newsDetailViewController.modalPresentationStyle = .fullScreen
//
//        newsDetailViewController.newsEntry = newsEntryToPass
//
//        self.navigationController?.present(navController, animated: true, completion: nil)

    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let indexPath = tableView.indexPathForSelectedRow {
//            let selectedRow = indexPath.row
//            let detailVC = segue.destination as! NewsDetailViewController
//            detailVC.newsEntry = self.news[selectedRow]
//        }
//    }

}
