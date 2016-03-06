//
//  Panic.swift
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import Parse

@objc(EVAPanic)
class Panic: PFObject, PFSubclassing {
    
    @NSManaged var user: PFUser?
    @NSManaged var location: String?
    @NSManaged var locationName: String?
    @NSManaged var timestamp: NSDate?
    @NSManaged var frontCameraImages: [PFFile]?
    @NSManaged var backCameraImages: [PFFile]?
    
    static func parseClassName() -> String {
        return "Panic"
    }
}
