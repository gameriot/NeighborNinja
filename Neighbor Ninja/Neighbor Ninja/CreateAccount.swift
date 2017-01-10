//
//  CreateAccount.swift
//  NeighborNinja
//
//  Created by Samast Varma on 6/27/16.
//  Copyright © 2016 Samast Varma. All rights reserved.
//

import UIKit
import MapKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class CreateAccount: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var AddressField: UITextField!
    @IBAction func CreateAccButton(_ sender: UIButton) {
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
                UserDefaults.standard.set(addressLat, forKey: "addressLat")
                UserDefaults.standard.set(addressLng, forKey: "addressLng")
                UserDefaults.standard.set(10000, forKey: "radius")
//                print (addressLat)
//                print (addressLng)
            }
        } as! CLGeocodeCompletionHandler)
        
            
        
        // store data
        
        UserDefaults.standard.set(userEmail, forKey: "userEmail")
        UserDefaults.standard.set(userPassword, forKey: "userPassword")
        UserDefaults.standard.set(userName, forKey: "userName")
        UserDefaults.standard.set(userAddress, forKey: "userAddress")
        
//        send data
//
        let addressLat = UserDefaults.standard.float(forKey: "addressLat")
        let addressLng = UserDefaults.standard.float(forKey: "addressLng")
        print (addressLat)
        print (addressLng)

        var request = URLRequest(url: URL(string: "http://ec2-54-215-141-57.us-west-1.compute.amazonaws.com/createAcc.php")!)
        request.httpMethod = "POST"
        let postString = "a=\(userName)&b=\(userEmail)&c=\(userPassword)&d=\(userAddress)&e=\(addressLat))&f=\(addressLng)"
        print (postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            UserDefaults.standard.synchronize()
            self.dismiss(animated: true, completion: nil)
        }) 
        task.resume()

        
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateAccount.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(CreateAccount.unwindSegue))
        swipe.direction = .right
        view.addGestureRecognizer(swipe)
        
        NameField.becomeFirstResponder()
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func unwindSegue(){
        self.performSegue(withIdentifier: "unwindCreate", sender: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

