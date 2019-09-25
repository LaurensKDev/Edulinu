//
//  ExtUpdateSearchResults.swift
//  Edulinu
//
//  Created by Laurens on 22.09.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation
import UIKit

extension TeacherTableViewController: UISearchResultsUpdating {
    
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
    
}
