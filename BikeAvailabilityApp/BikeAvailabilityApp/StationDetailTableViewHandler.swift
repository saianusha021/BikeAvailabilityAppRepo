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
        if stationObj != nil {
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
            cell.setLabels(fieldName: "StationName", fieldValue: stationObj.stationName!)
        case 1:
            cell.setLabels(fieldName: "Docks", fieldValue:"\(stationObj.availableDocks!)/\(stationObj.totalDocks!)")
        case 2:
            cell.setLabels(fieldName: "Bikes Available", fieldValue: String(stationObj.availableBikes!))
        default:
            cell.setLabels(fieldName: "Adress", fieldValue:"\(stationObj.stAddress1!)\(stationObj.stAddress2!)")
        }
        return cell
    }
}
