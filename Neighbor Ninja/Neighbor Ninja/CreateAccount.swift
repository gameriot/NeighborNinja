//
//  CreateAccount.swift
//  NeighborNinja
//
//  Created by Samast Varma on 6/27/16.
//  Copyright © 2016 Samast Varma. All rights reserved.
//

import UIKit

class CreateAccount: UIViewController {

    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var AddressField: UITextField!
    @IBAction func CreateAccButton(sender: UIButton) {
        // check if fields are empty 
        
        let userName = NameField.text!
        let userEmail = EmailField.text!
        let userPassword = PasswordField.text!
        let userAddress = AddressField.text!
        
        // store data
        
        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword")
        NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")

        NSUserDefaults.standardUserDefaults().synchronize()
        
        func displayMyAlertMessage(userMessage:String) {
            let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default, handler:nil);
            
            myAlert.addAction(okAction);
            
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        
        
        if(userName.isEmpty || userPassword.isEmpty || userEmail.isEmpty || userAddress.isEmpty) {
            // display error message
            displayMyAlertMessage("All fields must be completed.")
            return;
        }
        
        // send data
//        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/userRegister.php")!)
//        request.HTTPMethod = "POST"
//        let postString = "name=\(userName)&email=\(userEmail)&password=\(userPassword)&address=\(userAddress)"
//        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
//            guard error == nil && data != nil else {                                                          // check for fundamental networking error
//                print("error=\(error)")
//                return
//            }
//            
//            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(response)")
//            }
//            
//            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("responseString = \(responseString)")
//        }
//        task.resume()
        
//        //send registration data to server
//        let myUrl = NSURL(string:"http://localhost:8888/userRegister.php")
//        let request = NSMutableURLRequest(URL:myUrl!)
//        request.HTTPMethod = "POST";
//        
//        let postString = "name=\(userName)&email=\(userEmail)&password=\(userPassword)&address=(userAddress)"
//        
//        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
//        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){data, response, error in
//            
//            if error != nil{
//                print("error=\(error)")
//                return
//            }
//        
//            do {
//                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
//    
//                
//                if let parseJSON = json{
//                    let resultValue = parseJSON["status"] as? String
//                    print("result: \(resultValue)")
//                    
//                    var isUserRegistered:Bool = false
//                    if(resultValue=="Success") {
//                        isUserRegistered=true
//                    }
//                    var messageToDisplay:String = parseJSON["message"] as! String!
//                    if(!isUserRegistered){
//                        messageToDisplay = parseJSON["message"] as! String!
//                    }
//                    dispatch_async(dispatch_get_main_queue(), {
//                        //confirmation alert
//                        let myAlert = UIAlertController(title:"Alert", message:messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert)
//                        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default){ action in self.dismissViewControllerAnimated(true, completion:nil)}
//                        myAlert.addAction(okAction)
//                        self.presentViewController(myAlert,animated:true,completion:nil)
//                    })
//                }
//                
//            } catch {
//                print(error)
//            }
//            
//            
//        }
//        
//        
//        task.resume()
        
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

