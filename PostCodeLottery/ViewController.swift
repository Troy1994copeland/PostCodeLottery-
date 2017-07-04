//
//  ViewController.swift
//  PostCodeLottery
//
//  Created by Troy Copeland on 03/07/2017.
//  Copyright © 2017 Troy Copeland. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton : FBSDKLoginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["email", "user_birthday", "public_profile"]
        
        //loginButton = LoginButton(readPermissions: [ .PublicProfile, .Email, .UserFriends ])
        
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        loginButton.delegate = self
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
        print(error)
        return
        }
        
        print("Successfully logged in with facebook")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

