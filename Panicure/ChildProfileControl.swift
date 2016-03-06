//
//  ChildProfileControl.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit

class ChildProfileControl: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton?
    
    weak var formController: ProfileInfoViewController?
    
    var lastField: UITextField? {
        get {
            return nil
        }
    }

    var profile: Profile!
    
    func shouldBeginEditing(withObject object: Profile) {
        self.profile = object
    }
    
    // don't override this?
    @IBAction func onNextButtonClicked(sender: AnyObject) {
        self.nextButtonClicked()
    }
    
    func nextButtonClicked() {
        
    }
    
    func showInvalidInputError() {
        let alertController = UIAlertController(title: "Error", message: "Some required fields are empty", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: {(action: UIAlertAction) in
            alertController.dismissViewControllerAnimated(false, completion: nil)
            })
        
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: false, completion: nil)
    }
    
    func validateInput() -> Bool {
        return false
    }

}