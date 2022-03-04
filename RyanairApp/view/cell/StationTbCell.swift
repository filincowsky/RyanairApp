//
//  StationTbCell.swift
//  RyanairApp
//
//  Created by Vitor Ribeiro on 02/03/2022.
//  Copyright © 2022 Ryanair. All rights reserved.
//

import UIKit

class StationTbCell: UITableViewCell {

    static let ID = "StationTbCell"

    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var country: UILabel!

    private(set) var station: Station!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(withStation: Station!) {
        self.station = withStation

        self.city.text = "\(withStation.name!) (\(withStation.code!))"
        self.country.text = "\(withStation.countryName!)"
    }
}
