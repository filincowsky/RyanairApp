//
//  Fare.swift
//  RyanairApp
//
//  Created by Vitor Filincowsky on 02/03/2022.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

struct BusinessFare: Codable {
    
  var fareKey: String?
  var fareClass: String?
  var fares: [Fare]?
}

struct Fare: Codable {
    
    var amount: Double = 0.0
    var count: Int = 0
    var type: String?
    var hasDiscount: Bool = false
    var publishedFare: Double = 0.0
}
