//
//  ReverseGeocoder.swift
//  Waver
//
//  Created by Sam Meech Ward on 2016-01-27.
//  Copyright © 2016 Ice House. All rights reserved.
//

import Foundation
import Bolts
import AddressBookUI
import CoreLocation
import Contacts

@objc(EVAReverseGeocoder)
class ReverseGeocoder: NSObject {
    
    private static var geocoder = CLGeocoder()
    class func setGeocoder(geocoder: CLGeocoder) {
        self.geocoder = geocoder
    }
    
    /**
     Get the placemark object given a core location object.
     - parameter location: The core location object to get the name for.
     - returns: The placemark object.
     */
    class func placemarkForLocation(location: CLLocation) -> BFTask {
        let currentTask = BFTaskCompletionSource()
        
        // Get the geocoded location
        geocoder.reverseGeocodeLocation(location) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            
            // Handle error
            if let error = error {
                currentTask.setError(error)
                return
            }
            
            // 
            let placemark = placemarks![0]
            currentTask.setResult(placemark)
        }
        
        return currentTask.task
    }
    
    /**
        Get the location name given a core location object.
        - parameter location: The core location object to get the name for.
        - returns: The location string.
    */
    class func locationNameForLocation(location: CLLocation) -> BFTask {
        let currentTask = BFTaskCompletionSource()
        
        // Get teh geocoded location
        placemarkForLocation(location).continueWithBlock { (task: BFTask) -> AnyObject? in
            // Handle error
            if let error = task.error {
                currentTask.setError(error)
                return nil
            }
            
            // Get the placemark name
            let placemark = task.result as! CLPlacemark
            let string = self.locaitonNameForPlacemark(placemark)
            currentTask.setResult(string)
            return nil
        }
        
        return currentTask.task
    }
    
    /**
        Get a location name given a placemark object.
        - parameter placemark: A core location placemark object.
        - returns: The name of the placemark.
    */
    class func locaitonNameForPlacemark(placemark: CLPlacemark) -> String {
//        if #available(iOS 9.0, *) {
//            let formatter = CNPostalAddressFormatter()
//            return formatter.stringFromPostalAddress(CNPostalAddress())
//        } else {
            // Fallback on earlier versions
            return ABCreateStringWithAddressDictionary(placemark.addressDictionary!, false)
//        }
    }
}
