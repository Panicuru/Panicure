//
//  LoginViewController.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func onLogin(sender: AnyObject) {
        if (emailField.text != nil && passwordField.text != nil) {
            PFUser.logInWithUsernameInBackground(emailField.text!, password: passwordField.text!, block: {(user: PFUser?, error: NSError?) in
                if error == nil {
                    print("Success")
                } else {
                    print(error)
                }
            })
            
        }
    }
    
}
