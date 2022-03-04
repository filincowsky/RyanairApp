//
//  StationListViewModel.swift
//  RyanairApp
//
//  Created by Vitor Ribeiro on 03/03/22.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

import Foundation

class StationListViewModel: NSObject {

    private var api: API!
    private var list: [Station]!
    private(set) var stations: [Station]! {
        didSet {
            self.bind()
        }
    }
    
    var bind : (() -> ()) = {}

    override init() {
        super.init()
        self.api = API()
        self.getStations()
    }

    func getStations() {
        self.api.getStations() { result in
            self.list = result.stations
            self.stations = result.stations
        }
    }
    
    func filter(withText: String) {
        self.stations = (withText.isEmpty ? self.list : self.list.filter { station in
            let text = withText.lowercased()
            return station.name?.lowercased().hasPrefix(text) ?? true
                || station.code?.lowercased().hasPrefix(text) ?? true
        })
    }

}
