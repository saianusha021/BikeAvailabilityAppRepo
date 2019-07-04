//
//  StationJsonModel.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 6/28/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit
//
//"executionTime":"2019-07-01 09:38:25 AM","stationBeanList":[{"id":168,"stationName":"W 18 St & 6 Ave","availableDocks":21,"totalDocks":47,"latitude":40.73971301,"longitude":-73.99456405,"statusValue":"In Service","statusKey":1,"availableBikes":25,"stAddress1":"W 18 St & 6 Ave","stAddress2":"","city":"","postalCode":"","location":"","altitude":"","testStation":false,"lastCommunicationTime":"2019-07-01 09:37:56 AM","landMark":""}

struct Station:Decodable {
    
    var id:Int?
    var stationName:String?
    var availableDocks:Int?
    var totalDocks:Int?
    var latitude:Double?
    var longitude:Double?
    var statusValue:String?
    var statusKey:Int?
    var availableBikes:Int?
    var stAddress1:String?
    var stAddress2:String?
    var city:String?
    var postalCode:String?
    var location:String?
    var altitude:String?
    var testStation:Bool?
    var lastCommunicationTime:String?
    var landMark:String?
}


struct StationJsonModel:Decodable {
    var executionTime:String?
    var stationBeanList:[Station]?
}

