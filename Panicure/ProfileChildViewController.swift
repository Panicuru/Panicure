//
//  ProfileChildViewController.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit

class ProfileChild1ViewController: ChildProfileControl {
    
    @IBOutlet weak var birthdatePicker: UIDatePicker?
    @IBOutlet weak var addressUnitField: UITextField?
    @IBOutlet weak var addressCityField: UITextField?
    @IBOutlet weak var provincePicker: UITextField?
    @IBOutlet weak var postCodeField: UITextField?
    @IBOutlet weak var phoneField: UITextField?
    @IBOutlet weak var contactPhoneField: UITextField?
    
    override func nextButtonClicked() {
        if (validateInput()) {
            self.profile.birthday = birthdatePicker?.date
            self.profile.addressUnit = addressUnitField?.text
            self.profile.addressCity = addressCityField?.text
            self.profile.province = provincePicker?.text
            self.profile.postalCode = postCodeField?.text
            self.profile.phone = phoneField?.text
            self.profile.contactPhone = contactPhoneField?.text
            
        } else {
            showInvalidInputError()
        }
    }
    
    override func validateInput() -> Bool {
        var returnVal = [addressCityField, addressUnitField, provincePicker, postCodeField, phoneField, contactPhoneField].filter({$0?.text == nil}).count == 0
        return birthdatePicker?.date != nil && returnVal
    }

}

class ProfileChild2ViewController: ChildProfileControl {
    
    @IBOutlet weak var weightField: UITextField?
    @IBOutlet weak var heightField: UITextField?
    @IBOutlet weak var hairColourField: UITextField?
    @IBOutlet weak var eyeColourField: UITextField?
    @IBOutlet weak var ethnicityField: UITextField?
    @IBOutlet weak var tattooCheck: UISwitch?
    
    override func nextButtonClicked() {
        if (validateInput()) {
            self.profile.weight = weightField?.text
            self.profile.height = heightField?.text
            self.profile.hairColour = hairColourField?.text
            profile.eyeColour = eyeColourField?.text
            profile.ethnicity = ethnicityField?.text
            profile.tattoo = (tattooCheck?.on)!
        } else {
            showInvalidInputError()
        }
    }
    
    override func validateInput() -> Bool {
        var num = [weightField, heightField, hairColourField, eyeColourField, ethnicityField].filter({$0?.text == nil}).count
        return num == 0
    }
    
}

class ProfileChild3ViewController: ChildProfileControl {
    
    @IBOutlet weak var disabilitySwitch: UISwitch?
    @IBOutlet weak var disabilityField: UITextField?
    @IBOutlet weak var pregnantSwitch: UISwitch?
    @IBOutlet weak var pregnantField: UITextField?
    @IBOutlet weak var firstLanguageField: UITextField?
    @IBOutlet weak var secondLanguageField: UITextField?
    @IBOutlet weak var additionalField: UITextField?
    
    override func nextButtonClicked() {
        if (validateInput()) {
            if (disabilitySwitch!.on) { profile.disabilities = disabilityField?.text }
            if (pregnantSwitch!.on) { profile.pregnancy = pregnantField?.text }
            profile.firstLanguage = firstLanguageField?.text
            profile.secondLanguage = secondLanguageField?.text
            profile.additionalInfo = additionalField?.text
            
        } else {
            showInvalidInputError()
        }
    }
    
    override func validateInput() -> Bool {
        if (disabilitySwitch!.on && disabilityField == nil) { return false }
        if (pregnantSwitch!.on && pregnantField!.text == nil) { return false }
        return firstLanguageField!.text != nil
    }
    
}

class ProfileChild4ViewController: ChildProfileControl {
    
    @IBOutlet weak var vehicleSwitch: UISwitch?
    @IBOutlet weak var makeField: UITextField?
    @IBOutlet weak var yearField: UITextField?
    @IBOutlet weak var modelField: UITextField?
    @IBOutlet weak var colourField: UITextField?
    @IBOutlet weak var licenseField: UITextField?
    
    override func nextButtonClicked() {
        if (validateInput()) {
            if (vehicleSwitch!.on) {
                profile.make = makeField?.text
                profile.model = modelField?.text
                profile.license = licenseField?.text
                profile.year = yearField?.text
                profile.colour = colourField?.text
            }
            
        } else {
            showInvalidInputError()
        }
    }
    
    override func validateInput() -> Bool {
        if (vehicleSwitch!.on) {
            var count = [makeField, yearField, modelField, colourField, licenseField].filter({$0?.text == nil}).count
            return count == 0
        } else {
            return true
        }
    }
    
}
