//
//  RequestLocationPermissionsViewController.swift
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit

@objc(EVARequestLocationPermissionsViewController)
class RequestLocationPermissionsViewController: UIViewController {

    let locationHelper = LocationHelper()
    
    var delegate: RequestLocationPermissionsViewControllerDelegate?
    
    /// The label describing why we need location
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make sure to dismiss this view if location services are enabled
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "makeSureLocationIsAuthroized", name: nil, object: nil)
        
        label.textColor = UIColor.eva_grayTextColor()
    }
    
    func makeSureLocationIsAuthroized() {
        if locationHelper.authorized {
            dismiss()
        }
    }
    
    @IBAction func enableLocation(sender: AnyObject) {
        
        locationHelper.requestAuthorization { authorized in
            if authorized {
                self.dismiss()
            } else {
                self.presentPermisionAlert()
            }
        }
    }
    
    /// Present an alert view to allow the user to update their permissions in settings.
    private func presentPermisionAlert() {
        let alertController = UIAlertController(
            title: "Background Location Access Disabled",
            message: "In order to be able to get your locaiton in an emergency, please open this app's settings and set location access to 'Always'.",
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
            if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        alertController.addAction(openAction)
        
        self.presentViewController(alertController, animated: true) {
        }
    }
    
    private func dismiss() {
        dismissViewControllerAnimated(true) {
            self.delegate?.requestLocationPermissionsViewControllerDidDismiss?(self)
        }
    }
}

@objc(EVARequestLocationPermissionsViewControllerDelegate)
protocol RequestLocationPermissionsViewControllerDelegate {
    
    /// Called when this view controller is dimissed
    optional func requestLocationPermissionsViewControllerDidDismiss(viewController: RequestLocationPermissionsViewController)
}
