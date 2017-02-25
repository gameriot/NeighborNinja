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
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        let userName = NameField.text!
        let userEmail = EmailField.text!
        let userPassword = PasswordField.text!
        let userAddress = AddressField.text!
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            print("Unable to Find Location for Address")
            
        } else {
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let coordinate = location.coordinate
                print("\(coordinate.latitude), \(coordinate.longitude)")
                let addressLat = coordinate.latitude
                let addressLng = coordinate.longitude
                UserDefaults.standard.set(addressLat, forKey: "addressLat")
                UserDefaults.standard.set(addressLng, forKey: "addressLng")
                UserDefaults.standard.set(10000, forKey: "radius")
            } else {
                print("No Matching Location Found")
            }
        }
        
        // store data
        
        UserDefaults.standard.set(userEmail, forKey: "userEmail")
        UserDefaults.standard.set(userPassword, forKey: "userPassword")
        UserDefaults.standard.set(userName, forKey: "userName")
        UserDefaults.standard.set(userAddress, forKey: "userAddress")
        
        //        send data
        //
        let addressLat = UserDefaults.standard.float(forKey: "addressLat")
        let addressLng = UserDefaults.standard.float(forKey: "addressLng")
        let token = UserDefaults.standard.string(forKey: "tokenGlobal")
        print(token!)
        print (addressLat)
        print (addressLng)
        
        
        var request = URLRequest(url: URL(string: "http://getnninja.com/server/createAcc.php")!)
        request.httpMethod = "POST"
        let postString = "a=\(userName)&b=\(userEmail)&c=\(userPassword)&d=\(userAddress)&e=\(addressLat))&f=\(addressLng)&g=\(token!)"
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
            OperationQueue.main.addOperation {
                self.performSegue(withIdentifier: "createToMain", sender: nil)
            }
        })
        task.resume()
    }
    
    
    @IBAction func CreateAccButton(_ sender: UIButton) {
        // check if fields are empty 

        let userAddress = AddressField.text!
        
        var address: String = userAddress
        
        var geocoder: CLGeocoder = CLGeocoder()
        // Geocode Address String
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
        var location: CLLocation?
        
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

