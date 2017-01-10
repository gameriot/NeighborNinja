//
//  Settings.swift
//  Neighbor Ninja
//
//  Created by Samast Varma on 7/7/16.
//  Copyright © 2016 Samast Varma. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class Settings: UIViewController {
    
    @IBOutlet weak var selectedCellLabel: UILabel!
    
    @IBOutlet weak var radiusLabel: UITextField!
    
    @IBOutlet weak var radiusValue: UILabel!
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
        var radius = UserDefaults.standard.float(forKey: "radius")
        
        self.radiusValue.text = "\(radius) m"

        let items = ["Home", "Report", "View", "Settings", "Sign Off"]
        self.selectedCellLabel.text = items.first
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green:100.0/255.0, blue:190.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: items[3], items: items as [AnyObject])
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
                self.performSegue(withIdentifier: "settingstohome", sender: self)
            }
            if self.selectedCellLabel.text == "View"{
                self.performSegue(withIdentifier: "settingstoview", sender: self)
            }
            if self.selectedCellLabel.text == "Report"{
                self.performSegue(withIdentifier: "settingstoreport", sender: self)
            }
            if self.selectedCellLabel.text == "Sign Off"{
                UserDefaults.standard.set(false, forKey:"isUserLoggedIn")
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: "loginView", sender: self)
            }
        }
        
        
        self.navigationItem.titleView = menuView
        
    }
    
    @IBAction func changeRadius(_ sender: AnyObject) {
        let radius = Float(radiusLabel.text!)
        UserDefaults.standard.set(radius, forKey: "radius")
        self.radiusValue.text = "\(radius!) m"
    }

}
