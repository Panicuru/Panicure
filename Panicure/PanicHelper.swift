//
//  PanicHelper.swift
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import Foundation

@objc(EVAPanicHelper)
class PanicHelper: NSObject {
    
    static let sharedInstance = PanicHelper()
    
    /// Manages all requests to core location.
    let locationHelper = LocationHelper()
    
    /// @name Constants
    
    /// The oldest allowable time for a location.
    let oldestLocationTime: NSTimeInterval = 5

    static func startPanicingWithCompletion(completion: ((error: NSError?) -> Void)?) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            completion?(error: nil)
        }
        
        // Get the current timestamp
        let date = NSDate()
        
        // Request the user's location
        sharedInstance.getUsersCurrentLocation() { location, error in
            
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
