//
//  Report.swift
//  Neighbor Ninja
//
//  Created by Samast Varma on 7/1/16.
//  Copyright © 2016 Samast Varma. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import MapKit
import CoreLocation

class Report: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myPicker: UIPickerView!
    let pickerData = ["Arrest","Arson","Assault","Burglary","Robbery","Shooting","Theft","Vandalism","Other","Unknown"]

    @IBOutlet weak var radiusValue: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()

    @IBOutlet weak var selectedCellLabel: UILabel!
    var menuView: BTNavigationDropdownMenu!
    
    override func viewDidAppear(_ animated: Bool){
        
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(!isUserLoggedIn){
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
        self.navigationItem.hidesBackButton = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPicker.dataSource = self
        myPicker.delegate = self
        
        
        var radius = UserDefaults.standard.float(forKey: "radius")
        self.radiusValue.text = "\(radius) m"
        
        let items = ["Home", "Report", "View", "Settings", "Sign Off"]
        self.selectedCellLabel.text = items.first
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green:100.0/255.0, blue:190.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: items[1], items: items as [AnyObject])
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.white
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            self.selectedCellLabel.text = items[indexPath]
            if self.selectedCellLabel.text == "Home"{
                self.performSegue(withIdentifier: "reporttohome", sender: self)
            }
            if self.selectedCellLabel.text == "View"{
                self.performSegue(withIdentifier: "reporttoview", sender: self)
            }
            if self.selectedCellLabel.text == "Settings"{
                self.performSegue(withIdentifier: "reporttosettings", sender: self)
            }
            if self.selectedCellLabel.text == "Sign Off"{
                UserDefaults.standard.set(false, forKey:"isUserLoggedIn")
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: "loginView", sender: self)
            }
        }
        
        
        self.navigationItem.titleView = menuView
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
    
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        let currentLat = location!.coordinate.latitude
        let currentLng = location!.coordinate.longitude
        UserDefaults.standard.set(currentLat, forKey: "currentLat")
        UserDefaults.standard.set(currentLng, forKey: "currentLng")
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Errors: " + error.localizedDescription)
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myLabel.text = pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blue])
        return myTitle
    }
    
    /* better memory management version */
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
        }
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.black])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .center
        UserDefaults.standard.set(titleData, forKey: "reportType")
        
        return pickerLabel!
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    // for best use with multitasking , dont use a constant here.
    //this is for demonstration purposes only.
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    
    @IBAction func submitButton(_ sender: AnyObject) {
        let currentLat = UserDefaults.standard.float(forKey: "currentLat")
        let currentLng = UserDefaults.standard.float(forKey: "currentLng")
        let type = UserDefaults.standard.string(forKey: "reportType")
        let radius = UserDefaults.standard.float(forKey: "radius")
        let userID = UserDefaults.standard.integer(forKey: "userID")
        let radiusSent = radius/0.000621371
        
        let descriptionSent = descriptionText.text

        var request = URLRequest(url: URL(string: "http://getnninja.com/server/crimeReport.php")!)
        request.httpMethod = "POST"
        let postString = "a=\(type!)&b=\(currentLat)&c=\(currentLng)&d=\(descriptionSent!)&e=\(radiusSent)&f=\(userID)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        self.performSegue(withIdentifier: "reporttohome", sender: self)
        
        let alert = UIAlertController(title: "Successfully Reported", message: "Suspicious activity was reported, and neighbors have been notified. Stay safe!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
            
        }) 
        
        task.resume()
        
    }
    
}
