//
//  FlightSearchViewModel.swift
//  RyanairApp
//
//  Created by Vitor Filincowsky on 02/03/2022.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

import Foundation

class FlightSearchViewModel: NSObject {

    private var api: API!
    private(set) var flightList: [FlightFareItem]! {
        didSet {
            self.bind()
        }
    }
    
    var searchParams: SearchParams!
    
    var bind : (() -> ()) = {}

    override init() {
        super.init()
        self.searchParams = SearchParams()
        self.api = API()
    }
    
    func stationSelected(_ station: Station, withTag: Int) -> String {
        if withTag == SearchTag.ORIGIN.rawValue {
            self.searchParams.origin = station
        } else if withTag == SearchTag.DESTINATION.rawValue {
            self.searchParams.destination = station
        }
        return "\(station.name!) (\(station.code!))"
    }
    
    func dateSelected(_ date: Date) {
        self.searchParams.departureDate = date
    }
    
    func paxSelected(count: Int, withTag: SearchTag) -> String {
        if withTag == SearchTag.ADULT {
            self.searchParams.adults = count
        } else if withTag == SearchTag.TEEN {
            self.searchParams.teens = count
        } else if withTag == SearchTag.CHILD {
            self.searchParams.children = count
        }
        return "\(count)"
    }

    func searchFlights() {
        self.api.getFlights(params: self.searchParams) { result in
            self.setFlightList(result: result)
        }
    }
    
    fileprivate func setFlightList(result: SearchResult?) {
        if result == nil || result?.trips?.count ?? 0 == 0 {
            self.flightList = []
            return
        }
        
        var list: [FlightFareItem] = []
        
        let trip = result?.trips![0]
        trip?.dates?.forEach { (date) in
            let flights = date.flights
            flights?.forEach{ (flight) in
                guard let _ = flight.regularFare else {
                    return
                }
                guard let _ = flight.time?[0] else {
                    return
                }
                
                var item = FlightFareItem()
                item.currency = result?.currency
                item.flight = flight
                item.dateTime = Utils.formatDepartureTime(dateTime: (flight.time?[0] ?? date.dateOut)!)
                list.append(item)
            }
        }
        
        self.flightList = list
    }

}
