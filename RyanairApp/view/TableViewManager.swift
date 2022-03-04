//
//  TableViewManager.swift
//  RyanairApp
//
//  Created by Vitor Ribeiro on 02/03/2022.
//  Copyright © 2022 Ryanair. All rights reserved.
//

import Foundation
import UIKit

class TableViewManager<CELL : UITableViewCell, T> : NSObject, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    private var cellIdentifier: String!
    private var items: [T]!
    var configureCell: (CELL, T) -> () = {_,_ in }
    var didSelect: (T) -> () = {_ in }
    var filter: (String) -> () = {_ in }
    
    init(cellIdentifier: String, items: [T], configureCell: @escaping (CELL, T) -> (), didSelect: @escaping (T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
        self.didSelect = didSelect
    }
    
    init(cellIdentifier: String, items: [T], configureCell: @escaping (CELL, T) -> (), didSelect: @escaping (T) -> (), filter: @escaping (String) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
        self.didSelect = didSelect
        self.filter = filter
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = items[indexPath.row]
        self.didSelect(item)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        self.filter(searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filter(searchBar.text ?? "")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        self.filter(searchBar.text ?? "")
    }
}
