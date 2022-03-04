//
//  Utils.swift
//  RyanairApp
//
//  Created by Vitor Ribeiro on 04/03/22.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

import Foundation

class Utils {
    
    static func formatDate(_ date: Date?) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        return dateformat.string(from: date ?? Date())
    }
    
    static func formatDepartureTime(dateTime: String) -> String {
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = isoFormatter.date(from: dateTime.replacingOccurrences(of: ".000", with: ""))
        
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd HH:mm"
        
        return dateformat.string(from: date ?? Date())
    }
}
