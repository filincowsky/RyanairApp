//
//  SearchResultTbCell.swift
//  RyanairApp
//
//  Created by Vitor Ribeiro on 04/03/22.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

import UIKit

class SearchResultTbCell: UITableViewCell {
    
    static let ID = "SearchResultTbCell"
    
    @IBOutlet weak var flightNum: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var fare: UILabel!
    
    var currency: String?
    var flightFareItem: FlightFareItem?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(withFareItem: FlightFareItem) {
        self.flightFareItem = withFareItem
        
        let flight = withFareItem.flight
        
        self.flightNum.text = flight?.flightNumber
        self.date.text = flightFareItem?.dateTime
        self.fare.text = "\(flightFareItem?.currency ?? "") \(flight?.regularFare?.fares?[0].amount ?? 0)"
    }
    
}
