import UIKit
import MapKit
import Foundation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
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
            if let loc: AnyObject! = (item["location_1"]!) {
//                let lat = (item["latitude"]! as! NSString).doubleValue
//                let lon = (item["longitude"]! as! NSString).doubleValue
                
                let block: String = item["block"] as! String
                let city: String = item["city"] as! String
                let state: String = item["state"] as! String
                let locationString: String = "\(block) \(city) \(state)"
//                print (locationString)
                
                var geocoder: CLGeocoder = CLGeocoder()
                geocoder.geocodeAddressString(locationString,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                    if (placemarks?.count > 0) {
                        var topResult: CLPlacemark = (placemarks?[0])!
                        var placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                        let lat = placemark.coordinate.latitude
                        let lng = placemark.coordinate.longitude
                        let latUsed = Double(lat)
                        let lngUsed = Double(lng)
                        lata += latUsed
                        lona += lngUsed
                        let a = MKPointAnnotation()
                        a.title = item["crimedescription"]! as! String
                        a.coordinate = CLLocationCoordinate2D (latitude: latUsed, longitude: lngUsed)
                        anns.append(a)
                        
                        // Set the annotations and center the map
                        if (anns.count > 0) {
                            print (a.title)
                            self.mapView.addAnnotations(anns)
                            let w = 1.0 / Double(anns.count)
                            let r = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: latUsed, longitude: lngUsed), 2000, 2000)
                            self.mapView.setRegion(r, animated: animated)
                        }
                    }
                
                })
                
            }

    }

}


}