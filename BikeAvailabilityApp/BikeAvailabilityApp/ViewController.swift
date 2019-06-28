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
    var sth:StationsTableViewHandler = StationsTableViewHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = sth
        self.tableView.delegate = sth
        self.showTableViewData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LabelCell")
    }
    

    func updateStationData(arrayOfStationData:[Station]) {
        sth.arrOfStations = arrayOfStationData
        self.tableView.reloadData()
    }
    
    func errorWithMessage(msg:String) {
        print(msg)
    }
    
    func showTableViewData() {
        let hc = HttpClient(delegate:self)
        hc.getStationData()
    }

}

