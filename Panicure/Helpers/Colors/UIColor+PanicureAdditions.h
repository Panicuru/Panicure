//
//  UIColor+PanicureAdditions.h
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (PanicureAdditions)

/**
 Covert a hexidecimal value into a `UIColor` object.
 @param hex The hexidecimal value, should be in "#FFFFFF" format.
 @return A UIColor object representing the passed in hexideciaml value.
 */
+ (UIColor *)colorWithHexValue:(NSString *)hex;

+ (UIColor *)eva_mainRedColor;

+ (UIColor *)eva_grayTextColor;
+ (UIColor *)eva_greyColor;



@end
