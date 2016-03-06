//
//  SignUpViewController.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var profileButton: UIButton!
    
    var savedImage: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer: UITapGestureRecognizer = UITapGestureRecognizer()
        view.addGestureRecognizer(recognizer)
        recognizer.addTarget(self, action: "dismissKeyboard:")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        if (validateInput()) {
            
            let newUser = PFUser()
            
            if (self.savedImage) {
                let data = UIImageJPEGRepresentation(self.profileButton.backgroundImageForState(.Normal)!, 0.5)
                let imageFile = PFFile(data: data!)
                imageFile!.saveInBackground()
                newUser["profilePicture"] = imageFile
            }
            
            newUser.username = emailField.text
            newUser.email = emailField.text
            newUser.password = passwordField.text
            
            newUser.signUpInBackgroundWithBlock({(success: Bool, error: NSError?) in
                if (error == nil) {
                    print("No error!")
                    self.performSegueWithIdentifier("showProfileForm", sender: self)
                } else {
                    self.showInvalidInputError()
                }
            })
        } else {
            showInvalidInputError()
        }
    }
    
    func validateInput() -> Bool {
        var returnVal = true
        returnVal = returnVal && (firstNameField.text != nil && lastNameField.text != nil)
        returnVal = returnVal && (emailField.text != nil)
        returnVal = returnVal && (passwordField.text == confirmPasswordField.text)
        return returnVal
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showProfileForm") {
            if let dvc = segue.destinationViewController as? ProfileInfoViewController {
                print("In prepare!!")
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
    
    func showInvalidInputError() {
        let alertController = UIAlertController(title: "Error", message: "Some required fields are empty", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: {(action: UIAlertAction) in
            alertController.dismissViewControllerAnimated(false, completion: nil)
        })
        
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: false, completion: nil)
    }
    
    @IBAction func selectPhoto(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .PhotoLibrary
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.profileButton.setBackgroundImage(image, forState: .Normal)
        self.dismissViewControllerAnimated(true, completion: nil)
        self.savedImage = true
        self.profileButton.setImage(nil, forState: .Normal)
    }
}
