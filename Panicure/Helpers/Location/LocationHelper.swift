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
    
    /// The last location recieved.
    private var _lastLocation: CLLocation?
    var lastLocation: CLLocation? {
        return _lastLocation
    }
    
    /// true when the user has authorized location updates, false otherwise
    var authorized: Bool {
        return CLLocationManager.locationServicesEnabled() && authorizationStatus == CLAuthorizationStatus.AuthorizedAlways;
    }
    
    /// The current athroization status of the app
    private var authorizationStatus: CLAuthorizationStatus = .NotDetermined
    
    /// @name Requesting Location
    typealias RequestLocationAuthorizationBlock = (authorized: Bool) -> Void
    typealias RequestLocationCompletionBlock = (location: CLLocation?, error: NSError?) -> Void

    /// The block that gets called when the location is received after requesting locaiton.
    var requestLocationBlock: RequestLocationCompletionBlock?
    /// The block that gets called when the authroization is updated after request authroization.
    var authorizeLocationBlock: RequestLocationAuthorizationBlock?
    
    
    // MARK: -
    // MARK: - Setup
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    // MARK: -
    // MARK: - Request
    
    /**
     Request authorization to get user's location.
     The completion block will only be called once, either with a locaiton or an error.
     */
    func requestAuthorization(completion: RequestLocationAuthorizationBlock) {
        // If its already authorized
        if authorized {
            completion(authorized: true)
            return
        }
        
        if authorizationStatus == CLAuthorizationStatus.Denied {
            // User denied and will not recieve notification
            completion(authorized: false)
            return
        }
        
        // Request authorization
        authorizeLocationBlock = completion
        locationManager.requestAlwaysAuthorization()
    }
    
    /**
    Request the user's current location
    The completion block will only be called once, either with a locaiton or an error.
    */
    func requestLocation(completion: RequestLocationCompletionBlock) throws {
        // Save the completion block
        requestLocationBlock = completion
    }
    
    // MARK: -
    // MARK: - Location Manager Delegate
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        // Update the status
        authorizationStatus = status
        
        // Call the completion bock 
        authorizeLocationBlock?(authorized: authorized)
        authorizeLocationBlock = nil
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // If a location exists in the array, update the current location and stop updates
        if let location = locations.last {
            // Update the completion block
            requestLocationBlock?(location: location, error: nil)
            requestLocationBlock = nil
            
            // Save this as the most recent location
            _lastLocation = location
            
            // Stop requesting locations
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        // Update the completion block
        requestLocationBlock?(location: nil, error: error)
        requestLocationBlock = nil
        
        // Stop requesting locations
        locationManager.stopUpdatingLocation()
    }
    
    
    // MARK: -
    // MARK: - Utility
    
    private var userDeniedAuthorizationError: NSError? {
        return NSError(domain: "AuthorizationErrorDomain", code: 69, userInfo: [NSLocalizedDescriptionKey: "User did not authorize requestAlwaysAuthorization."])
    }
}
