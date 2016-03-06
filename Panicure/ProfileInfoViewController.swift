//
//  ProfileInfoViewController.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit
import Parse

class ProfileInfoViewController: UIViewController {
    
    // The values are 0 to 3
    var currentIndex: Int = 0
    var viewControllers: [ChildProfileControl] = [ChildProfileControl]()
    var profile: Profile?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (var i = 1; i < 5; i++) {
            let storyboard = UIStoryboard(name: "ProfileChildren", bundle: nil)
            
            if let childViewController: ChildProfileControl = storyboard.instantiateViewControllerWithIdentifier("profileChild" + String(i)) as? ChildProfileControl {
                addChildViewController(childViewController)
                childViewController.formController = self
            
                viewControllers.append(childViewController)
            }
        }
        displayViewAtIndex(currentIndex)
    }

    func userDidCompleteForm(withObject profile: Profile) {
        if (self.currentIndex < 3) {
            removeView()
            self.currentIndex = self.currentIndex + 1
            displayViewAtIndex(self.currentIndex)
        } else if (self.currentIndex == 3) {
            //finish and save
            self.profile?.encryptDecrypt()
            self.profile?.saveInBackgroundWithBlock({(success: Bool, error: NSError?) in
                if error == nil && success {
                    PFUser.currentUser()?.setObject(self.profile!, forKey: "profile")
                    PFUser.currentUser()?.saveInBackgroundWithBlock({(success: Bool, error: NSError?) in
                        print("Success: " + String(success))
                        self.removeView()
                        self.performSegueWithIdentifier("showMain", sender: self)
                    })
                }
            })
        }
    }
    
    func displayViewAtIndex(index: Int) {
        print("Displaying at " + String(index))
        self.view.addSubview(viewControllers[index].view)
        viewControllers[index].shouldBeginEditing(withObject: profile!)
        viewControllers[index].didMoveToParentViewController(self)
        viewControllers[index].view.autoPinEdgesToSuperviewEdges()
    }
    
    func removeView() {
        print("Removing at " + String(currentIndex))
        viewControllers[currentIndex].didMoveToParentViewController(nil)
        self.viewControllers[currentIndex].view.removeFromSuperview()
        viewControllers[currentIndex].removeFromParentViewController()
        
    }
    
    func userDidCancelEditing() {
        if (currentIndex == 0) {
            // do something
        } else if (currentIndex > 0) {
            currentIndex -= 1
            displayViewAtIndex(currentIndex)
        }
    }
    
    

}
