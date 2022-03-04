//
//  api.swift
//  RyanairApp
//
//  Created by Vitor Filincowsky on 02/03/2022.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

import Foundation

class API : NSObject {
    
    private static let BAR_SEP = "/"
    private static let PARAM_IND = "?"
    private static let PARAM_SEP = "&"

    func getStations(completion : @escaping (Stations) -> ()) {
        let url = URL(string: Routes.URL_STATIONS)!
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let data = try! jsonDecoder.decode(Stations.self, from: data)
                completion(data)
            }
        }.resume()
    }
    
    func getFlights(params: SearchParams, completion : @escaping (SearchResult?) -> ()) {
        let paramsDict = self.getFlightParamsDict(params: params)
        let urlString: String = self.addParamsToUrl(Routes.URL_AVAILABILITY, params: paramsDict)
        print(urlString)
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let data = try jsonDecoder.decode(SearchResult.self, from: data)
                    completion(data)
                } catch {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    // MARK: Helpers
    
    func getRequestUrlWithParams(url: String, params: [String : String]) -> URL {
        return URL(string: addParamsToUrl(url, params: params))!
    }
    
    func getFlightParamsDict(params: SearchParams) -> [String : String] {
        var dict: [String : String] = [:]
        dict["origin"] = params.origin?.code
        dict["destination"] = params.destination?.code
        dict["dateout"] = Utils.formatDate(params.departureDate)
        dict["datein"] = ""
        dict["flexdaysbeforeout"] = "3"
        dict["flexdaysout"] = "3"
        dict["flexdaysbeforein"] = "3"
        dict["flexdaysin"] = "3"
        dict["adt"] = "\(params.adults ?? 1)"
        dict["teen"] = "\(params.teens ?? 0)"
        dict["chd"] = "\(params.children ?? 0)"
        dict["roundtrip"] = "false"
        dict["ToUs"] = "AGREED"
        dict["Disc"] = "0"
        
        return dict
    }
    
    func addParamsToUrl(_ url: String, params: [String : String]) -> String {
        var newUrl = url + API.PARAM_IND
        var count = 0
        let sortedParams = params.sorted {
            return $0 < $1
        }
        for (key, value) in sortedParams {
            count += 1
            let paramUrl = value
            newUrl = newUrl + "\(key)=\(paramUrl)" + (count == params.count ? "" : API.PARAM_SEP)
        }
        return newUrl
    }
    
}
