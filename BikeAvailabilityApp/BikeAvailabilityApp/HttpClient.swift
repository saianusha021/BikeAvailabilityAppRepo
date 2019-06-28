//
//  HttpBikesClient.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 6/24/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit

protocol StationDataProtocol {
    func updateStationData(arrayOfStationData:[Station])
    func errorWithMessage(msg:String)
}

class HttpClient: NSObject {
    var delegate:StationDataProtocol
    let session:URLSession
    var  url:URL

    init(delegate:StationDataProtocol) {
        self.delegate = delegate
        session = URLSession.shared
        url = URL(string: "https://feeds.citibikenyc.com/stations/stations.json")!
    }
    func getStationData() {
        
//        let session:URLSession
//        var  url:URL
//        session = URLSession.shared
//        url = URL(string: "https://feeds.citibikenyc.com/stations/stations.json")!
        
        var arrOfStations = [Station]()
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                self.delegate.errorWithMessage(msg: "Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                self.delegate.errorWithMessage(msg: "Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                self.delegate.errorWithMessage(msg: "Wrong MIME type!")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                let stationsList = json.value(forKey: "stationBeanList")! as! NSArray
                //print(stationsList.count)
                for stationDict in stationsList {
                    let stationDictTemp = stationDict as! NSDictionary
                    var s = Station()
                    //print("altitude---\(s.altitude)")
                    s.stationName = stationDictTemp["stationName"] as! String
                    s.availableBikes = (stationDictTemp["availableBikes"] as! Int)
                    arrOfStations.append(s)
                }
                self.delegate.updateStationData(arrayOfStationData: arrOfStations)
                return
            } catch {
                self.delegate.errorWithMessage(msg: "JSON error: \(error.localizedDescription)")
                return
            }
        }
        
        task.resume()
        
    }

}
