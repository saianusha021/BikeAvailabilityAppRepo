//
//  ViewController.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 6/24/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit


class ViewController: UIViewController,BikeDataProtocol {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let hbc = HttpBikesClient(delegate: self)
        hbc.getStationsData()
    }
    
    func updateBikeData(arrayOfStations:[Station]) {
        
    }
    
    func responseWithError(msg: String) {
        
    }

}

