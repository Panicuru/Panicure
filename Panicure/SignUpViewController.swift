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
        let newUser = PFUser()
        newUser.username = emailField.text
        newUser.email = emailField.text
        newUser.password = passwordField.text
        newUser.signUpInBackgroundWithBlock({(success: Bool, error: NSError?) in
            if (error == nil) {
                print("No error!")
                self.performSegueWithIdentifier("showProfileForm", sender: self)
            }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showProfileForm") {
            if let dvc = segue.destinationViewController as? ProfileInfoViewController {
                let newProfile = Profile()
                newProfile.firstName = firstNameField.text
                newProfile.lastName = lastNameField.text
                dvc.profile = newProfile
            }
        }
    }
    
    func dismissKeyboard(sender: AnyObject) {
        print("Dismiss?")
        passwordField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
    }
}
