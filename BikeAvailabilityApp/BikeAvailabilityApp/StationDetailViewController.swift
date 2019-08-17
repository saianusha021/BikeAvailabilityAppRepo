//
//  StationDetailViewController.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 7/1/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit
import MapKit
import FBSDKLoginKit
import FacebookShare
import FBSDKShareKit

class StationDetailViewController: UIViewController {

    var stationObj:Station?
    
    @IBOutlet weak var tableView: UITableView!
    var stationDetTVHandler = StationDetailTableViewHandler()
    @IBOutlet weak var goButton: UIButton!
    var fbProfileImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(userIsLoggedInWithFB()) {
            self.showProfilePicture(image: self.fbProfileImage!)
            self.addShareButton()
            self.setUpTableView()
        }
            
        else {
            self.showLogInViewController()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Station"
    }
    func showProfilePicture(image:UIImage) {
        let profileButton = UIButton(frame: CGRect(x:0, y: 0, width:45, height:45))
        profileButton.addTarget(self, action: Selector("profilePictureTapped"), for: .touchUpInside)
        profileButton.setImage(image, for: .normal)
        let rightButton = UIBarButtonItem(customView: profileButton)
        self.navigationItem.setRightBarButtonItems([rightButton], animated: true)
    }
    
    func setUpTableView()  {
        self.tableView.delegate = stationDetTVHandler
        self.tableView.dataSource = stationDetTVHandler
        stationDetTVHandler.stationObj = self.stationObj!
    }
    
    @objc func profilePictureTapped() {
        self.logOutButtonTapped()
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
    
   
    
    @IBAction func goButtonTapped(_ sender: Any) {
            
        let latitude: CLLocationDegrees = stationObj?.latitude! ?? 0.0
            let longitude: CLLocationDegrees = stationObj?.longitude! ?? 0.0
            
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = stationObj?.stationName!
            mapItem.openInMaps(launchOptions: options)
        
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let content = ShareLinkContent.init()
        content.contentURL = URL(string: "https://developers.facebook.com")!
    }
    
    func addShareButton() {
        let fbShareButton = FBShareButton()
        //fbShareButton.center = view.center
        let content = ShareLinkContent()
        content.contentURL = URL(string: "https://developers.facebook.com")!
        fbShareButton.shareContent = content
        view.addSubview(fbShareButton)
        
        fbShareButton.translatesAutoresizingMaskIntoConstraints = false
        let constX:NSLayoutConstraint = NSLayoutConstraint(item: fbShareButton, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.goButton, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: self.goButton.frame.width+75);
        self.view.addConstraint(constX);
        
        let constY:NSLayoutConstraint = NSLayoutConstraint(item: fbShareButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.goButton, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant:0);
        self.view.addConstraint(constY);
        print(fbShareButton.frame)
    }
   
    func userIsLoggedInWithFB()->Bool {
        return AccessToken.current != nil
    }
    func showLogInViewController() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController!.present(vc, animated:false, completion: nil)
    }
    
   
    
//    func addLogoutButton() {
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .done, target: self, action: #selector(logOutButtonTapped))
//    }

    
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
