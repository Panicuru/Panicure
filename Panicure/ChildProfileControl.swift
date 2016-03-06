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
    
    weak var parentViewController: ProfileInfoViewController?
    
    var profile: Profile
    
    func shouldBeginEditing(withObject object: Profile) {
        self.profile = profile
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
                self.dismissViewControllerAnimated(alertController, completion: nil)
            })
        
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: false)
    }
    
    func validateInput() -> Bool {
        // implement me
    }
}