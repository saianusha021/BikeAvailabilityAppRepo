//
//  LoginViewController.swift
//  BikeAvailabilityApp
//
//  Created by Anusha Meda on 7/5/19.
//  Copyright © 2019 Anusha Meda. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

class LoginViewController: UIViewController,
LoginButtonDelegate{
    let fbLoginHandler = FacebookLoginHandler()
    
    override func viewDidLoad() {
    
        let fbLoginButton = FBLoginButton()
        fbLoginButton.center = view.center
        view.addSubview(fbLoginButton)
        fbLoginButton.delegate = self
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        loginButton.isHidden = true
        if ((result?.token) != nil) {
           self.dismiss(animated: false, completion: nil)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
}
