//
//  PanicHelper.swift
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import Foundation

@objc(EVAPanicHelper)
class PanicHelper: NSObject {

    static func startPanicingWithCompletion(completion: ((error: NSError?) -> Void)?) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            completion?(error: nil)
        }
        
        
    }
}
