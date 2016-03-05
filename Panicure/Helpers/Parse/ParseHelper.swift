//
//  ParseHelper.swift
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import Foundation
import Parse

@objc(EVAParseHelper)
class ParseHelper: NSObject {
    
    static func Start() {
        Parse.setApplicationId(ParseKeys.ApplicationId, clientKey: ParseKeys.ClientKey)
    }
}
