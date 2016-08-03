//
//  CreateAccount.swift
//  NeighborNinja
//
//  Created by Samast Varma on 6/27/16.
//  Copyright © 2016 Samast Varma. All rights reserved.
//

import UIKit
import MapKit

class CreateAccount: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

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
        
        var address: String = userAddress
        var geocoder: CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(address,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if (placemarks?.count > 0) {
                var topResult: CLPlacemark = (placemarks?[0])!
                var placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                let lat = placemark.coordinate.latitude
                let lng = placemark.coordinate.longitude
                let addressLat = Float(lat)
                let addressLng = Float(lng)
                NSUserDefaults.standardUserDefaults().setFloat(addressLat, forKey: "addressLat")
                NSUserDefaults.standardUserDefaults().setFloat(addressLng, forKey: "addressLng")
                NSUserDefaults.standardUserDefaults().setObject(10000, forKey: "radius")
//                print (addressLat)
//                print (addressLng)
            }
        })
        
            
        
        // store data
        
        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword")
        NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
        NSUserDefaults.standardUserDefaults().setObject(userAddress, forKey: "userAddress")
        
//        send data
//
        let addressLat = NSUserDefaults.standardUserDefaults().floatForKey("addressLat")
        let addressLng = NSUserDefaults.standardUserDefaults().floatForKey("addressLng")
        print (addressLat)
        print (addressLng)

        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://ec2-54-215-141-57.us-west-1.compute.amazonaws.com/createAcc.php")!)
        request.HTTPMethod = "POST"
        let postString = "a=\(userName)&b=\(userEmail)&c=\(userPassword)&d=\(userAddress)&e=\(addressLat))&f=\(addressLng)"
        print (postString)
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        task.resume()

        
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        var swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "unwindSegue")
        swipe.direction = .Right
        view.addGestureRecognizer(swipe)
        
        NameField.becomeFirstResponder()
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func unwindSegue(){
        self.performSegueWithIdentifier("unwindCreate", sender: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

