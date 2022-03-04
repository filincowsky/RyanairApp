//
//  Trip.swift
//  RyanairApp
//
//  Created by Vitor Filincowsky on 02/03/2022.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

struct Trip: Decodable {
    
    var origin: String?
    var destination: String?
    var dates: [FlightDate]?
}
