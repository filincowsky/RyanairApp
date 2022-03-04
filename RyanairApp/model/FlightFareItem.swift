//
//  FlightFareItem.swift
//  RyanairApp
//
//  Created by Vitor Ribeiro on 04/03/22.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

import Foundation

struct FlightFareItem: Decodable {
    
    var currency: String?
    var flight: Flight?
    var dateTime: String?
}
