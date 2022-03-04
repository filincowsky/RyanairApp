//
//  SearchResult.swift
//  RyanairApp
//
//  Created by Vitor Filincowsky on 02/03/2022.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

struct SearchResult: Decodable {
    
    var currency: String?
    var serverTimeUTC: String?  // "2016-04-11T11:39:35.268Z"
    var currPrecision: Int?
    var trips: [Trip]?
}
