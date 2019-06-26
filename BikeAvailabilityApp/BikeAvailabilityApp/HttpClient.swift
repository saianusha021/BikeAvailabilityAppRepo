//
//  HttpBikesClient.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 6/24/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit

protocol StationDataDelegate {
    func updateStationData(arrayOfStationData:[Station])
    func errorWithMessage(msg:String)
}

class HttpClient: NSObject {
    var delegate:StationDataDelegate
    let session:URLSession
    let url:URL
    
    init(delegate:StationDataDelegate) {
        self.delegate = delegate
        session = URLSession.shared
        url = URL(string: "https://feeds.citibikenyc.com/stations/stations.json")!
    }
    func getStationData() {
        
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
               var stationsList = json.value(forKey: "stationBeanList")! as! NSArray
                print(stationsList.count)
                for stationDict in stationsList {
                    var stationDictTemp = stationDict as! NSDictionary
                    var s = Station()
                    s.altitude = stationDictTemp["altitude"] as! String
                    s.availableDocks = stationDictTemp["availableDocks"] as! Int
                    arrOfStations.append(s)
                }
                self.delegate.updateStationData(arrayOfStationData: arrOfStations)
                
            } catch {
                self.delegate.errorWithMessage(msg: "JSON error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
        
    }

}
