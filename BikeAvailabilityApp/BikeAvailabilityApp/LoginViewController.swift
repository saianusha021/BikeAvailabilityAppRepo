//
//  LoginViewController.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 7/5/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        let loginButton = FBLoginButton(permissions: [ .publicProfile ])
        loginButton.center = view.center
        view.addSubview(loginButton)
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
