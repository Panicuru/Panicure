//
//  ProfileInfoViewController.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit

class ProfileInfoViewController: UIViewController {
    
    // The values are 1 to 4
    var currentIndex: Int = 1
    var viewControllers: [ChildProfileControl] = [ChildProfileControl]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "ProfileChildren.storyboard", bundle: nil)
        
        for (var i = 1; i < 5; i++) {
            if let childViewController: ChildProfileControl = storyboard.instantiateViewControllerWithIdentifier("profileChild1") as? ChildProfileControl {
                addChildViewController(childViewController)
                childViewController.view.frame = self.view.bounds
            
                viewControllers.append(childViewController)
            }
        }
        
        
    }

    func userDidCompleteForm(withObject profile: Profile) {
        if (currentIndex < 4) {
            currentIndex += 1
            displayViewAtIndex(currentIndex)
            viewControllers[currentIndex].shouldBeginEditing(withObject: profile)
        } else if (currentIndex == 4) {
            //finish and save
        }
    }
    
    func displayViewAtIndex(index: Int) {
        self.view.addSubview(viewControllers[index].view)
        viewControllers[index].didMoveToParentViewController(self)
        //childViewController.view.autoPinEdgesToSuperviewEdges()
    }
    
    func userDidCancelEditing() {
        if (currentIndex == 1) {
            // do something
        } else if (currentIndex > 1) {
            currentIndex -= 1
            displayViewAtIndex(currentIndex)
        }
    }
    
    

}
