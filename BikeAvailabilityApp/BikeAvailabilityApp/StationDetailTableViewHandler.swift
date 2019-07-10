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
        if stationObj.stationName!.isEmpty {
         return 0
        }
        else {
         return 4
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
