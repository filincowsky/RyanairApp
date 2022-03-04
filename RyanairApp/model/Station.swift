//
//  Station.swift
//  RyanairApp
//
//  Created by Vitor Filincowsky on 02/03/2022.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

struct Stations: Codable {
    var stations: [Station]?
}

struct Station: Codable {
    
    var code: String?
    var name: String?
    var alternateName: String?
    var alias: [String]?
    var countryCode: String?
    var countryName: String?
    var countryAlias: String?
    var countryGroupCode: String?
    var countryGroupName: String?
    var timeZoneCode: String?
    var latitude: String?
    var longitude: String?
    var mobileBoardingPass: Bool = true
    var markets: [Market]?
    var notices: String?
    var tripCardImageUrl: String?
}
