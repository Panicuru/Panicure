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
        if (emailField.text?.characters.count > 0 && passwordField.text?.characters.count > 0) {
            PFUser.logInWithUsernameInBackground(emailField.text!, password: passwordField.text!, block: {(user: PFUser?, error: NSError?) in
                if error == nil {
                    self.performSegueWithIdentifier("showMain", sender: self)
                } else {
                    self.showInvalidInputError()
                }
            })
            
        } else {
            showInvalidInputError()
        }
    }
    
    func showInvalidInputError() {
        let alertController = UIAlertController(title: "Error", message: "Some required fields are empty", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: {(action: UIAlertAction) in
            alertController.dismissViewControllerAnimated(false, completion: nil)
        })
        
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: false, completion: nil)
    }
    
}
