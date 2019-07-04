//
//  StationDetailViewController.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 7/1/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit

class StationDetailViewController: UIViewController {

    var stationObj:Station?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoTextView: UITextView!
    
    var stationDetTVHandler = StationDetailTableViewHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = stationDetTVHandler
        self.tableView.dataSource = stationDetTVHandler
        stationDetTVHandler.stationObj = self.stationObj!
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Station"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
