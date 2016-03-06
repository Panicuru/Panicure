//
//  EncryptionHelper.swift
//  Panicure
//
//  Created by Anya McGee on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import UIKit

@objc(EVAEncryptionHelper)
class EncryptionHelper: NSObject {
    
    static func encryptDecryptString(string: String?) -> String? {
        if let input: String = string {
            return XOREncryption.encryptDecrypt(input)
        } else {
            return nil
        }
    }

}

extension Character
{
    func unicodeScalarCodePoint() -> UInt32
    {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex].value
    }
    
}
