//
//  StationTableViewCell.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 7/1/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {

    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var numOfBikesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // // Configure the view for the selected state
    }

}
