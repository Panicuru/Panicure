//
//  Profile.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit

@objc(EVAProfile)
class Profile: PFObject {
    
    @NSManaged var user: PFUser
    
    @NSManaged var birthday: Date
    
    @NSManaged var addressUnit: String
    @NSManaged var addressCity: String
    @NSManaged var province: String
    @NSManaged var postalCode: String
    
    @NSManaged var phone: String
    @NSManaged var contactPhone: String
    
    @NSManaged var weight: String
    @NSManaged var height: String
    @NSManaged var hairColour: String
    @NSManaged var eyeColour: String
    @NSManaged var ethnicity: String
    @NSManaged var tattoos: Bool
    
    @NSManaged var disabilities: String
    @NSManaged var pregnancy: String
    @NSManaged var firstLanguage: String
    @NSManaged var secondLanguage: String
    @NSManaged var additionalInfo: String
    
    @NSManaged var make: String
    @NSManaged var model: String
    @NSManaged var year: String
    @NSManaged var colour: String
    @NSManaged var license: String
    
    func encryptDecrypt() {
        // todo: implement when more properties added
    }
    
}
