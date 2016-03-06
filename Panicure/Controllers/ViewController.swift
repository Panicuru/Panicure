//
//  ViewController.swift
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RequestLocationPermissionsViewControllerDelegate {
    
    var locaitonHelper = LocationHelper()
    var locaitonRequestViewController: RequestLocationPermissionsViewController?
    var viewHasAppeared = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Make sure locaiton services are enabled when the user returns from the background
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "makeSureLocationIsAuthroized", name: nil, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        viewHasAppeared = true
        makeSureLocationIsAuthroized()
        
        if locaitonHelper.authorized {
            locaitonHelper.requestLocation() { location, error in
                print("location: \(location), error: \(error)")
            }
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        viewHasAppeared = false
    }
    
    func makeSureLocationIsAuthroized() {
        
        if viewHasAppeared == false || locaitonRequestViewController != nil {
            return
        }
        
        // Check if the view controller is currently visible
        if let viewController = locaitonRequestViewController where viewController.view.window != nil {
            return
        }
        
        if locaitonHelper.authorized == false {
            
            // Show the location permission request view controller
            let storyboard = UIStoryboard(name: "RequestLocationPermision", bundle: nil)
            locaitonRequestViewController = storyboard.instantiateViewControllerWithIdentifier("EVARequestLocationPermissionsViewController") as? RequestLocationPermissionsViewController
            locaitonRequestViewController?.delegate = self
            presentViewController(locaitonRequestViewController!, animated: true, completion: nil)
            return
        }
    }

    func requestLocationPermissionsViewControllerDidDismiss(viewController: RequestLocationPermissionsViewController) {
        locaitonRequestViewController = nil
    }
    
    // MARK: -
    // MARK: - Actions
    
    @IBAction func panicNow() {
        PanicHelper.startPanicingWithCompletion { (error: NSError?, panic: Panic?) in
            let message = error == nil ? "Success" : "error"
            let alertController = UIAlertController(title: message, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelPanic() {
        
    }
}

