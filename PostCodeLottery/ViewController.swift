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
    
    var email1 : String = ""
    var firstName1 : String = ""
    var lastName1 : String = ""
    var gender1 : String = ""
    var age1 : String = ""
    var age_no : NSNumber = 0
    var id1 : String = ""
    var locale1 : String = ""
    var picture1 : NSString = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton : FBSDKLoginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["email", "user_birthday", "public_profile"]
        
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        loginButton.delegate = self
        
        if (FBSDKAccessToken.current()) != nil {
        fetchProfile()
        }
        
       
    }
    
    func fetchProfile() {
    print("fetchProfile")
        
    
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, first_name, last_name, gender, age_range, id, locale, picture"]).start { (connection, result, error) -> Void in
            
            if error != nil {
            print(error!)
            return
            }
            
            if let email = (result as AnyObject)["email"] as? String {
                self.email1 = email
                print(email)
            }
            
            if let firstName = (result as AnyObject)["first_name"] as? String {
               self.firstName1 = firstName
               print(firstName)
            }
            
            if let lastName = (result as AnyObject)["last_name"] as? String {
                self.lastName1 = lastName
                print(lastName)
            }
            
            if let gender = (result as AnyObject)["gender"] as? String {
                self.gender1 = gender
                print(gender)
            }
            
            if let age = (result as AnyObject)["age_range"] as? NSDictionary {
                
                self.age_no = age["min"] as! NSNumber
                self.age1 = String(describing: self.age_no)
                print(self.age1)
                
            }
            
            if let id = (result as AnyObject)["id"] as? String {
                self.id1 = id
                print(id)
            }

            if let locale = (result as AnyObject)["locale"] as? String {
                self.locale1 = locale
                print(locale)
            }

            if let picture = (result as AnyObject)["picture"] as? NSDictionary {
                //print(picture)
                if let data = (picture as AnyObject)["data"] as? NSDictionary {
                    
                    self.picture1 = data["url"] as! NSString
                    print(data["url"] as! String)
                }
            }
            
           
    }
        data_request("http://recommended-apps.com/api/validatefb.php")
        
}
   
    func data_request(_ url:String)
    {
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        let paramString = "email\(email1)&first_name=\(firstName1)&last_name\(lastName1)&id\(id1)&gender\(gender1)&locale\(locale1)&age\(age1)&picture\(picture1)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
            }
        }
        
        task.resume()
        
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

