//
//  StationDetailTableViewHandler.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 7/1/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit

class StationDetailTableViewHandler: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    var stationObj:Station = Station()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // if you make `stationName` non-optional, then the parsing will fail if `stationName` is not provided. maybe this something you want.

        // also look at the concept of "failable initializers" in swift. not for decodables, but just for
        // general knowledge
        if stationObj.stationName != nil {
         return 4
        }
        else {
         return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "StationDetailCell", for: indexPath) as! StationDetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.setLabels(fieldName: "Station", fieldValue: stationObj.stationName!)
        case 1:
            cell.setLabels(fieldName: "Docks", fieldValue:"\(stationObj.availableDocks!)/\(stationObj.totalDocks!)")
        case 2:
            cell.setLabels(fieldName: "Bikes Available", fieldValue: String(stationObj.availableBikes!))
        default:
            cell.setLabels(fieldName: "Time to go", fieldValue:"15mins from your location")
        }
        return cell
    }
}
