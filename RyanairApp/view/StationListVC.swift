//
//  StationListVC.swift
//  RyanairApp
//
//  Created by Vitor Ribeiro on 03/03/22.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

import UIKit

class StationListVC: UIViewController {

    static let ID: String = "StationListVC"

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var tableViewManager : TableViewManager<StationTbCell, Station>!
    private var viewModel: StationListViewModel!
    
    var station: Station?
    var callback : ((Station)->())?

    override func viewDidLoad() {
        tableView.register(UINib(nibName: StationTbCell.ID, bundle: nil), forCellReuseIdentifier: StationTbCell.ID)
        self.updateUI()
    }

    func updateUI() {
        self.viewModel = StationListViewModel()
        self.viewModel.bind = {
            self.updateDataSource()
        }
    }

    func updateDataSource() {
        self.tableViewManager = TableViewManager(
            cellIdentifier: StationTbCell.ID,
            items: self.viewModel.stations,
            configureCell: { (cell, station) in
                cell.setup(withStation: station)
            },
            didSelect: { (station) in
                if let _ = self.callback {
                    self.callback!(station)
                }
                self.dismiss(animated: true, completion: nil)
            },
            filter: { (text) in
                self.viewModel.filter(withText: text)
            }
        )
        
        DispatchQueue.main.async {
            self.searchBar.delegate = self.tableViewManager
            self.tableView.dataSource = self.tableViewManager
            self.tableView.delegate = self.tableViewManager
            self.tableView.reloadData()
        }
    }

}
