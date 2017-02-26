//
//  SignIn.swift
//  NeighborNinja
//
//  Created by Samast Varma on 6/27/16.
//  Copyright © 2016 Samast Varma. All rights reserved.
//

import UIKit

class SignIn: UIViewController {

    @IBOutlet weak var EmailSignIn: UITextField!
    @IBOutlet weak var PasswordSignIn: UITextField!
    @IBAction func SignInButton(_ sender: UIButton) {
        
        var email = self.EmailSignIn.text
        var password = self.PasswordSignIn.text
        
        let userEmail = EmailSignIn.text!
        let userPassword = PasswordSignIn.text!
        
        UserDefaults.standard.set(userEmail, forKey: "userEmail")
        
        var request = URLRequest(url: URL(string: "http://getnninja.com/server/loginAcc.php")!)
        request.httpMethod = "POST"
        let postString = "a=\(userEmail)&b=\(userPassword)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
            print(responseString)
            if (responseString == "0"){
                print ("No account")
            }
            else {
                print ("Account found")
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
                OperationQueue.main.addOperation {
                    self.performSegue(withIdentifier: "loginToMain", sender: nil)
                }
            }
        }) 
        task.resume()

        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"background")!)
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignIn.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SignIn.unwindSegue))
        swipe.direction = .right
        view.addGestureRecognizer(swipe)
        
        EmailSignIn.becomeFirstResponder()
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func unwindSegue(){
        self.performSegue(withIdentifier: "unwindLogin", sender: nil)
    }

    
}
