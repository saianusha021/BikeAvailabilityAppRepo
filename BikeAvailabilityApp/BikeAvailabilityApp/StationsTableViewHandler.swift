//
//  StationsTableViewHandler.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 6/26/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit

protocol TableViewReloadProtocol {
    func reloadTableViewData()
}

class StationsTableViewHandler: NSObject,UITableViewDataSource,UITableViewDelegate {
    
    var arrOfStations:[Station]
    //var delegate:TableViewReloadProtocol
    
    override init() {
        //self.delegate = delegate
        arrOfStations = [Station]()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count---\(arrOfStations.count)")
        return arrOfStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as! StationTableViewCell
        let s:Station = arrOfStations[indexPath.row]
        cell.stationNameLabel.text = s.stationName!
        cell.numOfBikesLabel.text  = String(s.availableBikes!)
        return cell
    }
    
    

//    init(tableView:UITableView) {
//        self.tableView =  tableView
//    }
    
}
