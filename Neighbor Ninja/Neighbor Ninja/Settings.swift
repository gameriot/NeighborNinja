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
    
    var menuView: BTNavigationDropdownMenu!
    
    override func viewDidAppear(animated: Bool){
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if(!isUserLoggedIn){
            self.performSegueWithIdentifier("loginView", sender: self)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let items = ["Home", "Report", "View", "Settings", "Sign Off"]
        self.selectedCellLabel.text = items.first
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green:100.0/255.0, blue:190.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: items[3], items: items)
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
                self.performSegueWithIdentifier("settingstohome", sender: self)
            }
            if self.selectedCellLabel.text == "View"{
                self.performSegueWithIdentifier("settingstoview", sender: self)
            }
            if self.selectedCellLabel.text == "Report"{
                self.performSegueWithIdentifier("settingstoreport", sender: self)
            }
            if self.selectedCellLabel.text == "Sign Off"{
                NSUserDefaults.standardUserDefaults().setBool(false, forKey:"isUserLoggedIn")
                NSUserDefaults.standardUserDefaults().synchronize()
                self.performSegueWithIdentifier("loginView", sender: self)
            }
        }
        
        
        self.navigationItem.titleView = menuView
        
    }

}
