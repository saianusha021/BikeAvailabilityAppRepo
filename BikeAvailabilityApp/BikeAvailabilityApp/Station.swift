//
//  BikesInfo.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 6/24/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit

struct Station {
    var altitude:String = ""
    var availableBikes:Int? = 0
    var availableDocks:Int? = 0
    var city:String = ""
    var id:Int? = 0
    var landMark:String = ""
    var lastCommunicationTime:String = ""
    var latitude:String = ""
    var location:String = ""
    var longitude:String = ""
    var postalcode:String = ""
    var stAddress1:String = ""
    var stAddress2:String = ""
    var stationName:String = ""
    var statusKey:Int? = 0
    var statusvalue:String = ""
    var testStation:Int? = 0
    var totalDocks:Int?
    
    init(stationDict:[String:Any]) {
        self.stationName = stationDict["stationName"] as! String
        self.availableBikes = stationDict["availableBikes"] as! Int
    }
}
