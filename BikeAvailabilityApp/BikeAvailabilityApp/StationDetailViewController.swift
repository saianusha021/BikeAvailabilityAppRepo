//
//  StationDetailViewController.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 7/1/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit
import MapKit
import FacebookShare
import FBSDKShareKit

class StationDetailViewController: UIViewController {

    var stationObj:Station?
    
    @IBOutlet weak var tableView: UITableView!
    var stationDetTVHandler = StationDetailTableViewHandler()
    
    @IBOutlet weak var goButton: UIButton!
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
   
    override func viewDidLoad() {
        super.viewDidLoad()
       self.addLogoutButton()
        self.addShareButton()
        self.tableView.delegate = stationDetTVHandler
        self.tableView.dataSource = stationDetTVHandler
        stationDetTVHandler.stationObj = self.stationObj!
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Station"
    }
    
    func addLogoutButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .done, target: self, action: #selector(logOutButtonTapped))
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
        
        
//        let constW:NSLayoutConstraint = NSLayoutConstraint(item: fbShareButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0);
//        self.view.addConstraint(constW);
//
//        let constH:NSLayoutConstraint = NSLayoutConstraint(item: fbShareButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0);
//        self.view.addConstraint(constH);
    }
    
    @objc func logOutButtonTapped() {
        
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
