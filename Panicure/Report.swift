//
//  Report.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit

class Report: PFObject {
    
    @NSManaged var media: PFFile?
    @NSManaged var detail: String
    @NSManaged var user: PFUser?
    @NSManaged var location: PFGeoPoint?
    
}
