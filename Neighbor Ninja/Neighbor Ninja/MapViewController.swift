//
//  MapViewController.swift
//  SODASample
//
//  Created by Frank A. Krueger on 8/10/14.
//  Copyright (c) 2014 Socrata, Inc. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    let addressLat = NSUserDefaults.standardUserDefaults().floatForKey("addressLat")
    let addressLng = NSUserDefaults.standardUserDefaults().floatForKey("addressLng")
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var data: [[String: AnyObject]]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWithData(data, animated: false)
    }
    
    func updateWithData(data: [[String: AnyObject]]!, animated: Bool) {
        
        // Remember the data because we may not be able to display it yet
        self.data = data
        
        if (!isViewLoaded()) {
            return
        }
        
        // Clear old annotations
        if mapView.annotations.count > 0 {
            let ex = mapView.annotations
            mapView.removeAnnotations(ex)
        }
        
        // Longitude and latitude accumulators so we can find the center
        var lata : CLLocationDegrees = 0.0
        var lona : CLLocationDegrees = 0.0
        
        // Create annotations for the data
        var anns : [MKAnnotation] = []
        for item in data {
            if let loc: AnyObject = item["location_1"] {
//                let lat = (item["latitude"]! as! NSString).doubleValue
//                let lon = (item["longitude"]! as! NSString).doubleValue
                let latlng = item["location_1"]!
                print (latlng)
                let lat = Double(addressLat)
                let lon = Double(addressLng)
                lata += lat
                lona += lon
                let a = MKPointAnnotation()
                a.title = item["crimedescription"]! as! String
                a.coordinate = CLLocationCoordinate2D (latitude: lata, longitude: lona)
                anns.append(a)
            }
        }
        
        // Set the annotations and center the map
        if (anns.count > 0) {
            mapView.addAnnotations(anns)
            let w = 1.0 / Double(anns.count)
            let r = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: lata*w, longitude: lona*w), 2000, 2000)
            mapView.setRegion(r, animated: animated)
        }

    }
}

