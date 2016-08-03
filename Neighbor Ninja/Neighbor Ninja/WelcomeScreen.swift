//
//  WelcomeScreen.swift
//  NeighborNinja
//
//  Created by Samast Varma on 6/27/16.
//  Copyright © 2016 Samast Varma. All rights reserved.
//

import UIKit

class WelcomeScreen: UIViewController {
    
    override func viewDidLoad() {
        //Check if login
    }
    

    @IBAction func CreateAccButton(sender: UIButton) {
        self.performSegueWithIdentifier("WelcometoCreate", sender: self)
    }
    
    @IBAction func SignInButton(sender: UIButton) {
        self.performSegueWithIdentifier("WelcometoSign", sender: self)
    }
        
}
