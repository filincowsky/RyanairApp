//
//  SearchParams.swift
//  RyanairApp
//
//  Created by Vitor Filincowsky on 03/03/2022.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

import Foundation

struct SearchParams: Codable {
    
    var origin: Station?
    var destination: Station?
    var departureDate: Date?
    var adults: Int?
    var teens: Int?
    var children: Int?
}
