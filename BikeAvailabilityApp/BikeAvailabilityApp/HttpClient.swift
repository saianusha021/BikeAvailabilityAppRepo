//
//  HttpBikesClient.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 6/24/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit

protocol DataHandlerProtocol {
    func updateStationData(arrayOfStationData:[Station])
    func errorWithMessage(msg:String)
    func updateProfilePicture(image:UIImage)
}


extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}

class HttpClient: NSObject {
    var dataHandlerDelegate:DataHandlerProtocol
    var session:URLSession

    init(delegate:DataHandlerProtocol) {
        self.dataHandlerDelegate = delegate
        session = URLSession.shared
    }
    
    func getStationData() {
        let url = URL(string:  "https://feeds.citibikenyc.com/stations/stations.json")!
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                self.dataHandlerDelegate.errorWithMessage(msg: "Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                self.dataHandlerDelegate.errorWithMessage(msg: "Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                self.dataHandlerDelegate.errorWithMessage(msg: "Wrong MIME type!")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                
                let jsonDataObj:StationJsonModel = try
                      JSONDecoder().decode(StationJsonModel.self, from: data!)
                DispatchQueue.main.async {
                    self.dataHandlerDelegate.updateStationData(arrayOfStationData: jsonDataObj.stationBeanList!)
                }
            } catch {
                self.dataHandlerDelegate.errorWithMessage(msg: "JSON error: \(error.localizedDescription)")
                return
            }
        }
        
        task.resume()
    }
    
    
    
    func getFBProfileImage(fromLink:String) {
        let image = UIImage(data: try! Data(contentsOf: URL(string:fromLink)!))!

        guard let thumb1 = image.resized(withPercentage: 0.80) else { return  self.dataHandlerDelegate.errorWithMessage(msg: "cant Resize the image!") }
        guard let thumb2 = image.resized(toWidth: 45.0) else { return self.dataHandlerDelegate.errorWithMessage(msg: "cant Resize the image!") }
        
        self.dataHandlerDelegate.updateProfilePicture(image: thumb2)

    }

}
