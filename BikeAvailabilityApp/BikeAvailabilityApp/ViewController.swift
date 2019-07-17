//
//  ViewController.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 6/24/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit


class ViewController: UIViewController,StationDataProtocol{
    
    @IBOutlet weak var tableView: UITableView!
    var stationTVHandler:StationsTableViewHandler = StationsTableViewHandler()
    var httpclientObj:HttpClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(userIsLoggedInWithFB()) {
            self.addLogoutButton()
            self.initialSetUp()
        }
        
        else {
            self.showLogInViewController()
        }
        
    }
    
    func initialSetUp() {
        self.tableView.dataSource = stationTVHandler
        self.tableView.delegate = stationTVHandler
        httpclientObj = HttpClient(delegate:self)
        httpclientObj!.getStationData()
    }
    func showLogInViewController() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController!.present(vc, animated:false, completion: nil)
    }
    func addLogoutButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(logOutButtonTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .done, target: self, action: #selector(logOutButtonTapped))
    }
    
    @objc func logOutButtonTapped() {
        let loginManager = LoginManager()
       loginManager.logOut()
        self.showLogInViewController()
    }
    func userIsLoggedInWithFB()->Bool {
        return AccessToken.current != nil
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

