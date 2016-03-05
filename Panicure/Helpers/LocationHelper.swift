//
//  LocationHelper.swift
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import Foundation
import CoreLocation

/// Manages all requests to core location
@objc(EVALocationHelper)
class LocationHelper: NSObject, CLLocationManagerDelegate {
    
    /// The core location manager.
    private let locationManager = CLLocationManager()
    
    /// true when the user has authorized location updates, false otherwise
    var authorized = false
    
    /// The current athroization status of the app
    private var authorizationStatus: CLAuthorizationStatus = kCLAuthorizationStatusNotDetermined
    
    typealias RequestLocationCompletionBlock = (location: CLLocation) -> Void

    
    
    /// Request authorization
    func requestAuthorization() {
        
    }
    
    /// Request the user's current location
    func requestLocation(completion: RequestLocationCompletionBlock) throws {
        
    }
    
    // MARK: -
    // MARK: - Location Manager Delegate
    
    
}
