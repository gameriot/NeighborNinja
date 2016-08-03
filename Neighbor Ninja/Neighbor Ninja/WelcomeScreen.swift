//
//  WelcomeScreen.swift
//  NeighborNinja
//
//  Created by Samast Varma on 6/27/16.
//  Copyright © 2016 Samast Varma. All rights reserved.
//

import UIKit

class WelcomeScreen: UIViewController {
    
    override func viewDidLoad() {
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if(isUserLoggedIn){
            
            let userEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")!
            print (userEmail)
            let request = NSMutableURLRequest(URL: NSURL(string: "http://ec2-54-215-141-57.us-west-1.compute.amazonaws.com/userID.php")!)
            request.HTTPMethod = "POST"
            let postString = "a=\(userEmail)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                
                print("response = \(response)!")
                
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString!)")
                NSUserDefaults.standardUserDefaults().setObject(responseString, forKey: "userID")
                //let userID = NSUserDefaults.standardUserDefaults().stringForKey("userID")!
                
            }
            task.resume()
            
            self.performSegueWithIdentifier("loginSegue", sender: self)

            
        }
    }
    

    @IBAction func CreateAccButton(sender: UIButton) {
        self.performSegueWithIdentifier("WelcometoCreate", sender: self)
    }
    
    @IBAction func SignInButton(sender: UIButton) {
        self.performSegueWithIdentifier("WelcometoSign", sender: self)
    }
    
    @IBAction func unwindToWelcome(segue: UIStoryboardSegue){
        
    }
}
