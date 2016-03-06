//
//  PanicHelper.swift
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import Foundation
import CoreLocation
import Parse

@objc(EVAPanicHelper)
class PanicHelper: NSObject {
    
    static let sharedInstance = PanicHelper()
    
    /// Manages all requests to core location.
    let locationHelper = LocationHelper()
    
    /// @name Constants
    
    /// The oldest allowable time for a location.
    let oldestLocationTime: NSTimeInterval = 5

    static func startPanicingWithCompletion(completion: ((error: NSError?) -> Void)?) {
        // Get the current timestamp
        let date = NSDate()
        
        // Request the user's location
        sharedInstance.getUsersCurrentLocation() { location, error in
            if error != nil {
                completion?(error: error)
                return
            }
            
            // Get the location name
            ReverseGeocoder.locationNameForLocation(location!).continueWithBlock({ (task: BFTask) -> AnyObject? in
                
                if let error = task.error {
                    completion?(error: error)
                    return nil
                }
                
                // Create a new panic
                let panic = Panic()
                let locaitonString = location!.eva_stringFromLocation()
                let locationName = task.result as? String
                panic.location = EncryptionHelper.encryptDecryptString(locaitonString)
                panic.user = PFUser.currentUser()
                panic.locationName = EncryptionHelper.encryptDecryptString(locationName)
                panic.timestamp = date
                
                // Save the panic
                let networkController = EVANetworkHelper.sharedInstance()
                networkController.saveNewPanic(panic, completion: { (error: NSError?) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if error != nil {
                            completion?(error: error)
                            return
                        }
                        completion?(error: nil)
                    })
                    
                })
                
                return nil
            })
        }
    }
    
    private func getUsersCurrentLocation(completion: LocationHelper.RequestLocationCompletionBlock) {
        // Check if the last location is accurate enough
        let lastLocation = locationHelper.lastLocation
        if let timeAgo = lastLocation?.timestamp.timeIntervalSinceNow {
            if timeAgo < 0 && timeAgo*(-1) < oldestLocationTime {
                // The last location is accurate enough
                completion(location: lastLocation, error: nil)
                return
            }
        }
        
        // Request a new location
        locationHelper.requestLocation(completion)
    }
}
