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


class ViewController: UIViewController,DataHandlerProtocol,UIPopoverControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var stationTVHandler:StationsTableViewHandler = StationsTableViewHandler()
    var httpclientObj:HttpClient?
    var imageView:UIImageView?
    var image :UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(userIsLoggedInWithFB()) {
           self.addLogoutButton(image: UIImage())
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
        self.getUserFBData()
    }
    func showLogInViewController() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController!.present(vc, animated:false, completion: nil)
    }
    func addLogoutButton(image:UIImage) {
        let profileButton = UIButton(frame: CGRect(x:0, y: 0, width:45, height:45))
        profileButton.addTarget(self, action: Selector("profilePictureTapped"), for: .touchUpInside)
        profileButton.setImage(image, for: .normal)
        let rightButton = UIBarButtonItem(customView: profileButton)
        self.navigationItem.setRightBarButtonItems([rightButton], animated: true)
    }
    
    @objc func profilePictureTapped() {
    var popoverContent = self.storyboard!.instantiateViewController(withIdentifier: "PopOverVC")
       popoverContent.modalPresentationStyle = .popover
        popoverContent.isModalInPopover = true
        popoverContent.preferredContentSize = CGSize(width:100,height: 100)
        self.present(popoverContent, animated: true, completion: nil)
        
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
    func updateProfilePicture(image:UIImage) {
        self.addLogoutButton(image: image)
    }
    
    func errorWithMessage(msg:String) {
        print(msg)
    }
    
    func getUserFBData()
    {
        let graphRequest : GraphRequest = GraphRequest.init(graphPath: "me",parameters: ["fields": "id, first_name,email,picture.type(large)"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil)
            {
                // Process error
                print("Error: \(String(describing: error))")
            }
            else
            {
                let fbData = result as! NSDictionary
                let fbProfilePic = fbData.value(forKey: "picture") as! NSDictionary
                let fbProfilePicData = fbProfilePic.value(forKey: "data") as! NSDictionary
                let fbProfilePicLink = fbProfilePicData.value(forKey: "url") as! String
               self.httpclientObj?.getFBProfileImage(fromLink: fbProfilePicLink)
                
                
            }
        })
    }

}

