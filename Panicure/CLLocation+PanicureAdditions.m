//
//  CLLocation+PanicureAdditions.m
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

#import "CLLocation+PanicureAdditions.h"

@implementation CLLocation (PanicureAdditions)

- (NSString *)eva_stringFromLocation {
    return [NSString stringWithFormat:@"%f,%f",self.coordinate.latitude, self.coordinate.longitude];
}

@end
