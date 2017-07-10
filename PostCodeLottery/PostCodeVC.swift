//
//  PostCodeVC.swift
//  PostCodeLottery
//
//  Created by Troy Copeland on 06/07/2017.
//  Copyright © 2017 Troy Copeland. All rights reserved.
//

import UIKit

class PostCodeVC: UIViewController {

    @IBOutlet weak var postCodeProgressView: UIProgressView!
    
    var email : String = ""
    var firstName : String = ""
    var lastName : String = ""
    var gender : String = ""
    var age : String = ""
    var id : String = ""
    var locale : String = ""
    var picture : NSString = ""
    var postCode : String = ""
    
    
    var timesTapped: Float = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PostCodeVC.dismissKeyboard))
        
        view.addGestureRecognizer(tap)

        self.postCodeProgressView.progress = 1.0
        
        //enterBtn disabled 
        regBtn.isEnabled = false
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBOutlet weak var postCodeText: UITextField!
    @IBOutlet weak var regBtn: UIButton!

    
    @IBAction func postCodeDidChange(_ sender: Any) {
        print("postCodeInput: \(String(describing: postCodeText.text))")
        postCode = String(describing: postCodeText.text)
        
        if validatePostCode(text: postCodeText.text!) {
        //valid post code 
         regBtn.isEnabled = true
        }
        
        else {
        regBtn.isEnabled = false
        }
    }
    
    
    @IBAction func regBtnPressed(_ sender: Any) {
        print("valid postcode")
        data_request("http://recommended-apps.com/api/validatefb.php")
        view.backgroundColor = UIColor.blue
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func validatePostCode(text: String) -> Bool {
    var result = true
    let postCodeRegEx = "^([A-z]){1,2}([1-9]){1,2} ?([0-9]){1,2}([A-z]){1,2}$"
        
        do {
            let regex = try NSRegularExpression(pattern: postCodeRegEx)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
            
            result = false
            }
        } catch let error as NSError {
        print("invalid postcode \(error.localizedDescription)")
        result = false
        }
    
     return result
    }
    
    func data_request(_ url:String)
    {
    
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        let paramString = "email=\(email)&first_name=\(firstName)&last_name=\(lastName)&id=\(id)&gender=\(gender)&locale=\(locale)&age=\(age)&picture=\(picture)&post_code=\(postCode)"
        print(paramString)
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

        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
