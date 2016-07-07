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
    
    override func viewDidAppear(animated: Bool){
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if(!isUserLoggedIn){
            self.performSegueWithIdentifier("loginView", sender: self)
        }
        self.navigationItem.hidesBackButton = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPicker.dataSource = self
        myPicker.delegate = self
        
        
        var radius = NSUserDefaults.standardUserDefaults().floatForKey("radius")
        self.radiusValue.text = "\(radius) m"
        
        let items = ["Home", "Report", "View", "Settings", "Sign Off"]
        self.selectedCellLabel.text = items.first
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green:100.0/255.0, blue:190.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: items[1], items: items)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
        menuView.keepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.whiteColor()
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .Left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.blackColor()
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            self.selectedCellLabel.text = items[indexPath]
            if self.selectedCellLabel.text == "Home"{
                self.performSegueWithIdentifier("reporttohome", sender: self)
            }
            if self.selectedCellLabel.text == "View"{
                self.performSegueWithIdentifier("reporttoview", sender: self)
            }
            if self.selectedCellLabel.text == "Settings"{
                self.performSegueWithIdentifier("reporttosettings", sender: self)
            }
            if self.selectedCellLabel.text == "Sign Off"{
                NSUserDefaults.standardUserDefaults().setBool(false, forKey:"isUserLoggedIn")
                NSUserDefaults.standardUserDefaults().synchronize()
                self.performSegueWithIdentifier("loginView", sender: self)
            }
        }
        
        
        self.navigationItem.titleView = menuView
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
    
    }

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        let currentLat = location!.coordinate.latitude
        let currentLng = location!.coordinate.longitude
        NSUserDefaults.standardUserDefaults().setObject(currentLat, forKey: "currentLat")
        NSUserDefaults.standardUserDefaults().setObject(currentLng, forKey: "currentLng")
        
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myLabel.text = pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blueColor()])
        return myTitle
    }
    
    /* better memory management version */
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
        }
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .Center
        NSUserDefaults.standardUserDefaults().setObject(titleData, forKey: "reportType")
        
        return pickerLabel
        
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    // for best use with multitasking , dont use a constant here.
    //this is for demonstration purposes only.
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    
    @IBAction func submitButton(sender: AnyObject) {
        let currentLat = NSUserDefaults.standardUserDefaults().floatForKey("currentLat")
        let currentLng = NSUserDefaults.standardUserDefaults().floatForKey("currentLng")
        let type = NSUserDefaults.standardUserDefaults().stringForKey("reportType")
        
        let descriptionSent = descriptionText.text
        
        
        print (type)
        print (currentLat)
        print (currentLng)
        print (descriptionSent)
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/crimeReport.php")!)
        request.HTTPMethod = "POST"
        let postString = "a=\(type)&b=\(currentLat)&c=\(currentLng)&d=\(descriptionSent)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        self.performSegueWithIdentifier("reporttohome", sender: self)
        
        let alert = UIAlertController(title: "Successfully Reported", message: "Suspicious activity was reported, and neighbors have been notified. Stay safe!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
        }
        task.resume()
        
        
        
        
    }
    
}



