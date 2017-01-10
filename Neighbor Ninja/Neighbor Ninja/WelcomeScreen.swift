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
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(isUserLoggedIn){
            
            let userEmail = UserDefaults.standard.string(forKey: "userEmail")!
            print (userEmail)
            var request = URLRequest(url: URL(string: "http://ec2-54-215-141-57.us-west-1.compute.amazonaws.com/userID.php")!)
            request.httpMethod = "POST"
            let postString = "a=\(userEmail)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            
//            var request = URLRequest(url: URL(string: "http://example.com")!)
//            request.httpMethod = "POST"
//            
//            URLSession.shared.dataTask(with: request) {data, response, err in
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: {
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                
                print("response = \(response)!")
                
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString = \(responseString!)")
                UserDefaults.standard.set(responseString, forKey: "userID")
                //let userID = NSUserDefaults.standardUserDefaults().stringForKey("userID")!
                
            }) 
            task.resume()
            
            self.performSegue(withIdentifier: "loginSegue", sender: self)

            
        }
    }
    

    @IBAction func CreateAccButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "WelcometoCreate", sender: self)
    }
    
    @IBAction func SignInButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "WelcometoSign", sender: self)
    }
    
    @IBAction func unwindToWelcome(_ segue: UIStoryboardSegue){
        
    }
}
