//
//  ViewController.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 6/24/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit


class ViewController: UIViewController,StationDataProtocol{
    
    @IBOutlet weak var tableView: UITableView!
    var stationTVHandler:StationsTableViewHandler = StationsTableViewHandler()
    var httpclientObj:HttpClient?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.dataSource = stationTVHandler
        self.tableView.delegate = stationTVHandler
        httpclientObj = HttpClient(delegate:self)
        httpclientObj!.getStationData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Stations"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let stationDetailVC = segue.destination as! StationDetailViewController
        let selectedCellRow:Int = self.tableView.indexPathForSelectedRow!.row
        stationDetailVC.stationObj = stationTVHandler.arrOfStations[selectedCellRow]
    }

    func updateStationData(arrayOfStationData:[Station]) {
        stationTVHandler.updateStationData(stations: arrayOfStationData)
        self.tableView.reloadData()
    }
    
    func errorWithMessage(msg:String) {
        print(msg)
    }

   
}

