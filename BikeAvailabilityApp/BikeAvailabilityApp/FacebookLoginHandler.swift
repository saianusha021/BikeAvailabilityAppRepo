//
//  FBLoginHandler.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 7/16/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FacebookLoginHandler: NSObject ,LoginButtonDelegate{

    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if ((result?.token) != nil) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            self
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    

}
