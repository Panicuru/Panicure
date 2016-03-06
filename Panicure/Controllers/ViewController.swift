//
//  ViewController.swift
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit
import SwiftyTimer

class ViewController: UIViewController, RequestLocationPermissionsViewControllerDelegate {
    
    /// Manages all requests to corelocation.
    var locaitonHelper = LocationHelper()
    /// The view controller that manages requesting location permissions.
    var locaitonRequestViewController: RequestLocationPermissionsViewController?
    /// true only after viewDidAppear has been called.
    var viewHasAppeared = false
    /// The timer that is used to countdown the timer label and panic.
    var timer: NSTimer?
    /// The label that shows the countdown.
    @IBOutlet weak var timerLabel: UILabel!
    /// The amount of time that has passed
    var timeRemaining: NSTimeInterval = 10 {
        didSet {
            updateTimer()
        }
    }
    
    // MARK: -
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Make sure locaiton services are enabled when the user returns from the background
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "makeSureLocationIsAuthroized", name: "applicationDidBecomeActive", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        timeRemaining = 10
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        viewHasAppeared = true
        if makeSureLocationIsAuthroized() {
            startTiming()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        viewHasAppeared = false
    }
    
    // MARK: -
    // MARK: - Location Authroziation
    
    func makeSureLocationIsAuthroized() -> Bool {
        if viewHasAppeared == false || locaitonRequestViewController != nil {
            return false
        }
        
        if locaitonHelper.authorized == false {
            
            // Show the location permission request view controller
            let storyboard = UIStoryboard(name: "RequestLocationPermision", bundle: nil)
            locaitonRequestViewController = storyboard.instantiateViewControllerWithIdentifier("EVARequestLocationPermissionsViewController") as? RequestLocationPermissionsViewController
            locaitonRequestViewController?.delegate = self
            presentViewController(locaitonRequestViewController!, animated: true, completion: nil)
            return false
        }
        
        return true
    }

    func requestLocationPermissionsViewControllerDidDismiss(viewController: RequestLocationPermissionsViewController) {
        locaitonRequestViewController = nil
        startTiming()
    }
    
    // MARK: -
    // MARK: - Timer
    
    private func startTiming() {
        timeRemaining = 10
        timer = NSTimer.new(every: 1.second) {
            self.timeRemaining -= 1
        }
        timer?.start(runLoop: NSRunLoop.currentRunLoop(), modes: NSRunLoopCommonModes)
    }
    
    private func stopTiming() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateTimer() {
        if timeRemaining <= 0 {
            stopTiming()
            startPanicing()
        }
        timerLabel.text = ("\(Int(timeRemaining))")
    }
    
    // MARK: -
    // MARK: - Panic
    
    private func startPanicing() {
        PanicHelper.startPanicingWithCompletion { (error: NSError?, panic: Panic?) in
            let message = error == nil ? "Success" : "error"
            let alertController = UIAlertController(title: message, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "okay", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(alertAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: -
    // MARK: - Actions
    
    @IBAction func panicNow() {
        startPanicing()
    }
    
    @IBAction func cancelPanic() {
        stopTiming()
    }
}

