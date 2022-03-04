//
//  Flight.swift
//  RyanairApp
//
//  Created by Vitor Filincowsky on 02/03/2022.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

struct FlightDate: Decodable {
    
    var dateOut: String?
    var flights: [Flight]?
}

struct Flight: Decodable {
    var time: [String]? // ["2016-04-12T10:00:00.000"]
    var regularFare: BusinessFare?
    var faresLeft: Int?
    var timeUTC: [String]? // ["2016-04-12T09:00:00.000Z"]
    var duration: String? // hh:mm
    var flightNumber: String?
    var infantsLeft: Int?
    var flightKey: String?
    var businessFare: BusinessFare?
}
