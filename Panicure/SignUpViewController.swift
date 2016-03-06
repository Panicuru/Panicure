//
//  SignUpViewController.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer: UITapGestureRecognizer = UITapGestureRecognizer()
        view.addGestureRecognizer(recognizer)
        recognizer.addTarget(self, action: "dismissKeyboard:")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        var newUser = PFUser()
        newUser.username = emailField.text
        newUser.email = emailField.text
        newUser.password = passwordField.text
        newUser.signUpInBackgroundWithBlock({(success: Bool, error: NSError?) in
            if (error == nil) {
                print("No error!")
            }
        })
    }
    
    func dismissKeyboard(sender: AnyObject) {
        print("Dismiss?")
        passwordField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
    }
}
