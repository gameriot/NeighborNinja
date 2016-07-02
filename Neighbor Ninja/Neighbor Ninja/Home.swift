//
//  Home.swift
//  NeighborNinja
//
//  Created by Samast Varma on 6/27/16.
//  Copyright © 2016 Samast Varma. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import BTNavigationDropdownMenu


class Home: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectedCellLabel: UILabel!
    var menuView: BTNavigationDropdownMenu!
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let items = ["Home", "Report", "View", "Settings", "Sign Off"]
        self.selectedCellLabel.text = items.first
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green:100.0/255.0, blue:190.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: items[0], items: items)
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
            if self.selectedCellLabel.text == "Report"{
                self.performSegueWithIdentifier("hometoreport", sender: self)
            }
            if self.selectedCellLabel.text == "View"{
                self.performSegueWithIdentifier("hometoview", sender: self)
            }
            if self.selectedCellLabel.text == "Settings"{
                
            }
            if self.selectedCellLabel.text == "Sign Off"{
                NSUserDefaults.standardUserDefaults().setBool(false, forKey:"isUserLoggedIn")
                NSUserDefaults.standardUserDefaults().synchronize()
                self.performSegueWithIdentifier("loginView", sender: self)
            }
        }

        
        self.navigationItem.titleView = menuView
//        nameLabel.font = nameLabel.font.fontWithSize(20)
//        if let name = NSUserDefaults.standardUserDefaults().stringForKey("userName") {
//            self.nameLabel.text = "Welcome " + name
//        }
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
        
    }
    
    @IBAction func logoutButton(sender: UIButton) {
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey:"isUserLoggedIn")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.performSegueWithIdentifier("loginView", sender: self)
    }
    override func viewDidAppear(animated: Bool){

        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if(!isUserLoggedIn){
            self.performSegueWithIdentifier("loginView", sender: self)
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
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
    
    @IBAction func viewButton(sender: AnyObject) {
        self.performSegueWithIdentifier("hometoview", sender: self)
    }
    
    @IBAction func reportButton(sender: AnyObject) {
        self.performSegueWithIdentifier("hometoreport", sender: self)
    }
    
}
