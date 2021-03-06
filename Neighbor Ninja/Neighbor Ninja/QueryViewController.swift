////
////  QueryViewController.swift
////  SODASample
////
////  Created by Frank A. Krueger on 8/10/14.
////  Copyright (c) 2014 Socrata, Inc. All rights reserved.
////
//
//import UIKit
//import BTNavigationDropdownMenu
//
//class QueryViewController: UITableViewController {
//    
//    @IBOutlet weak var selectedCellLabel: UILabel!
//    var menuView: BTNavigationDropdownMenu!
//
//    
//    // Register for access tokens here: http://dev.socrata.com/register
//
//    let addressLat = UserDefaults.standard.float(forKey: "addressLat")
//    let addressLng = UserDefaults.standard.float(forKey: "addressLng")
//    let radius = UserDefaults.standard.float(forKey: "radius")
//    
//    let client = SODAClient(domain: "data.acgov.org", token: "KjCEUpVrY1K2HuxgCbSP8Fdxb")
//    
//    let cellId = "DetailCell"
//    
//    var data: [[String: AnyObject]]! = []
//                            
//    override func viewDidAppear(_ animated: Bool){
//        self.navigationItem.hidesBackButton = true
////        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
////        if(!isUserLoggedIn){
////            self.performSegueWithIdentifier("viewtohome", sender: self)
////        }
//    }
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let items = ["Home", "Report", "View", "Settings", "Sign Off"]
//        self.selectedCellLabel.text = items.first
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green:100.0/255.0, blue:190.0/255.0, alpha: 1.0)
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
//        
//        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: items[2], items: items)
//        menuView.cellHeight = 50
//        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
//        menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
//        menuView.keepSelectedCellColor = true
//        menuView.cellTextLabelColor = UIColor.white
//        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
//        menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
//        menuView.arrowPadding = 15
//        menuView.animationDuration = 0.5
//        menuView.maskBackgroundColor = UIColor.black
//        menuView.maskBackgroundOpacity = 0.3
//        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
//            print("Did select item at index: \(indexPath)")
//            self.selectedCellLabel.text = items[indexPath]
//            if self.selectedCellLabel.text == "Report"{
//                self.performSegue(withIdentifier: "viewtoreport", sender: self)
//            }
//            if self.selectedCellLabel.text == "Home"{
//                self.performSegue(withIdentifier: "viewtohome", sender: self)
//            }
//            if self.selectedCellLabel.text == "Settings"{
//                self.performSegue(withIdentifier: "viewtosettings", sender: self)
//            }
//            if self.selectedCellLabel.text == "Sign Off"{
//                UserDefaults.standard.set(false, forKey:"isUserLoggedIn")
//                UserDefaults.standard.synchronize()
//                self.performSegue(withIdentifier: "loginView", sender: self)
//            }
//        }
//        self.navigationItem.titleView = menuView
//
//
//        // Create a pull-to-refresh control
//        refreshControl = UIRefreshControl ()
//        refreshControl?.addTarget(self, action: #selector(QueryViewController.refresh(_:)), for: UIControlEvents.valueChanged)
//        
//        // Auto-refresh
//        refresh(self)
//    }
//    
//    /// Asynchronous performs the data query then updates the UI
//    func refresh (_ sender: AnyObject!) {
//        print (addressLat)
//        print (addressLng)
//        let cngQuery = client.queryDataset("js8f-yfqf").filter("within_circle(location_1, \(addressLat), \(addressLng), \(radius)) AND crimedescription IS NOT NULL")
//        
//        cngQuery.orderDescending("datetime").get { res in
//            switch res {
//            case .dataset (let data):
//                // Update our data
//                self.data = data
//            case .error (let err):
//                let alert = UIAlertView(title: "Error Refreshing", message: err.userInfo.debugDescription, delegate: nil, cancelButtonTitle: "OK")
//                alert.show()
//            }
//            
//            // Update the UI
//            self.refreshControl?.endRefreshing()
//            self.tableView.reloadData()
//            self.updateMap(animated: true)
//        }
//    }
//    
//    /// Finds the map controller and updates its data
//    fileprivate func updateMap(animated: Bool) {
//        if let tabs = (self.parent?.parent as? UITabBarController) {
//            if let mapNav = tabs.viewControllers![1] as? UINavigationController {
//                if let map = mapNav.viewControllers[0] as? MapViewController {
//                    map.updateWithData (data, animated: animated)
//                }
//            }
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView!, didSelectRowAt indexPath: IndexPath) {
//        // Show the map
//        if let tabs = (self.parent?.parent as? UITabBarController) {
//            tabs.selectedIndex = 1
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let c = tableView.dequeueReusableCell(withIdentifier: cellId) as UITableViewCell!
//        
//        let item = data[indexPath.row]
//        
//        let name = item["crimedescription"]! as! String
//        c?.textLabel?.text = name
//        
//        let street = item["block"]! as! String
//        let city = item["city"] as! String
//        let state = "CA"
//        let date = item["datetime"] as! String
//        c?.detailTextLabel?.text = "\(date),\(street), \(city), \(state)"
//        
//        return c!
//    }
//}
