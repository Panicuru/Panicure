//
//  Report.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit
import Parse

@objc(EVAReport)
class Report: PFObject {
    
    @NSManaged var media: PFFile?
    @NSManaged var detail: String?
    @NSManaged var user: PFUser?
    @NSManaged var location: String?
    
    var geopoint: PFGeoPoint? {
        get {
            if let location = location {
                let strings: [String] = location.componentsSeparatedByString(",")
                if (strings.count > 2) {
                    let lat = Double(strings.first!)
                    let lon = Double(strings.last!)
                    if (lat != nil && lon != nil) {
                        return PFGeoPoint(latitude: lat!, longitude: lon!)
                    }
                }
            }
            return nil
        }
        set(newPoint) {
            self.location = String(newPoint?.latitude) + "," + String(newPoint?.longitude)
        }
    }
    
    func encryptDecrypt() {
        self.detail = EncryptionHelper.encryptDecryptString(self.detail)
        self.location = EncryptionHelper.encryptDecryptString(self.location)
    }
    
}
