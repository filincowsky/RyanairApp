//
//  FlightSearchFormVC.swift
//  RyanairApp
//
//  Created by Vitor Ribeiro on 02/03/2022.
//  Copyright © 2022 Ryanair. All rights reserved.
//

import UIKit

class FlightSearchFormVC: UIViewController, UITextFieldDelegate {

    static let ID: String = "FlightSearchFormVC"
    static let MIN_PAX: Int = 1
    static let MAX_PAX: Int = 6
    
    @IBOutlet weak var txtOrigin: UITextField!
    @IBOutlet weak var txtDestination: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var txtAdults: UITextField!
    @IBOutlet weak var txtTeens: UITextField!
    @IBOutlet weak var txtChildren: UITextField!
    @IBOutlet weak var tableView: UITableView!
    private var dataSource : TableViewManager<SearchResultTbCell, FlightFareItem>!
    private var viewModel: FlightSearchViewModel!
    private var paxSettingsDict: [Int : PaxSettingViewModel] = [:]

    override func viewDidLoad() {
        tableView.register(UINib(nibName: SearchResultTbCell.ID, bundle: nil), forCellReuseIdentifier: SearchResultTbCell.ID)
        txtOrigin.delegate = self
        txtDestination.delegate = self
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(FlightSearchFormVC.departureDateChanged), for: .valueChanged)
        self.updateUI()
    }
    
    fileprivate func bindPaxSettings() {
        
        let paxAdultVM = PaxSettingViewModel(min: FlightSearchFormVC.MIN_PAX, max: FlightSearchFormVC.MAX_PAX)
        paxAdultVM.bind = { (pax) in
            self.txtAdults.text = self.viewModel.paxSelected(count: pax, withTag: SearchTag.ADULT)
        }
        
        let paxTeenVM = PaxSettingViewModel(min: 0, max: FlightSearchFormVC.MAX_PAX)
        paxTeenVM.bind = { (pax) in
            self.txtTeens.text = self.viewModel.paxSelected(count: pax, withTag: SearchTag.TEEN)
        }
        
        let paxChildrenVM = PaxSettingViewModel(min: 0, max: FlightSearchFormVC.MAX_PAX)
        paxChildrenVM.bind = { (pax) in
            self.txtChildren.text = self.viewModel.paxSelected(count: pax, withTag: SearchTag.CHILD)
        }
        
        self.paxSettingsDict = [
            SearchTag.ADULT.rawValue : paxAdultVM,
            SearchTag.TEEN.rawValue : paxTeenVM,
            SearchTag.CHILD.rawValue : paxChildrenVM
        ]
    }

    fileprivate func updateUI() {
        self.viewModel = FlightSearchViewModel()
        self.viewModel.bind = {
            self.updateDataSource()
        }
        self.bindPaxSettings()
    }

    func updateDataSource() {
        self.dataSource = TableViewManager(
            cellIdentifier: SearchResultTbCell.ID,
            items: self.viewModel.flightList,
            configureCell: { (cell, flightFareItem) in
                cell.setup(withFareItem: flightFareItem)
            },
            didSelect: { (flightFareItem) in
                print(flightFareItem.flight!)
            }
        )
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.delegate = self.dataSource
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier) {
        case StationListVC.ID:
            let vc = segue.destination as! StationListVC
            let tag = sender as! Int
            vc.callback = { result in
                let stationInfo = self.viewModel.stationSelected(result, withTag: tag)
                if tag == SearchTag.ORIGIN.rawValue {
                    self.txtOrigin.text = stationInfo
                } else if tag == SearchTag.DESTINATION.rawValue {
                    self.txtDestination.text = stationInfo
                }
            }
            return
        default:
            return
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let tag = SearchTag.init(rawValue: textField.tag)
        switch (tag) {
        case .ORIGIN, .DESTINATION:
            performSegue(withIdentifier: StationListVC.ID, sender: textField.tag)
            break
        default:
            break
        }
        
        return false
    }
    
    @objc private func departureDateChanged() {
        self.viewModel.dateSelected(datePicker.date)
        presentedViewController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func onSearchFlights(_ sender: Any) {
        self.viewModel.searchFlights()
    }
    
    @IBAction func onIncrement(_ sender: Any) {
        let tag = (sender as! UIButton).tag
        self.paxSettingsDict[tag]?.onIncrement()
    }
    
    @IBAction func onDecrement(_ sender: Any) {
        let tag = (sender as! UIButton).tag
        self.paxSettingsDict[tag]?.onDecrement()
    }
    
}
