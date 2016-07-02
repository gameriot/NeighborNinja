//
//  Report.swift
//  Neighbor Ninja
//
//  Created by Samast Varma on 7/1/16.
//  Copyright © 2016 Samast Varma. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class Report: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var selectedCellLabel: UILabel!
    var menuView: BTNavigationDropdownMenu!
    
    @IBOutlet weak var picker1: UIPickerView!
    var picker1Data: [String] = [String]()
    
    var locationAnswer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // input data
        picker1Data = ["Yes", "No"]
        
        //connect data
        self.picker1.delegate = self
        self.picker1.dataSource = self
        
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
                
            }
            if self.selectedCellLabel.text == "Sign Off"{
                NSUserDefaults.standardUserDefaults().setBool(false, forKey:"isUserLoggedIn")
                NSUserDefaults.standardUserDefaults().synchronize()
                self.performSegueWithIdentifier("loginView", sender: self)
            }
        }
        
        
        self.navigationItem.titleView = menuView
    
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return picker1Data.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return picker1Data[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(row == 0)
        {
            self.view.backgroundColor = UIColor.whiteColor();
            var locationAnswer = "Yes"
        }
        else if(row == 1)
        {
            self.view.backgroundColor = UIColor.redColor();
            var locationAnswer = "No"
        }
    }
    @IBAction func submitButton(sender: AnyObject) {
    }
}
