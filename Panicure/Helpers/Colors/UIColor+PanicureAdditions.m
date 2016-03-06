//
//  UIColor+PanicureAdditions.m
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

#import "UIColor+PanicureAdditions.h"

@implementation UIColor (PanicureAdditions)

+ (UIColor *)colorWithHexValue:(NSString *)hex {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


+ (UIColor *)eva_mainRedColor {
    return [self colorWithHexValue:@"#981417"];
}

+ (UIColor *)eva_grayTextColor {
    return [self colorWithHexValue:@"#4a4a4a"];
}
+ (UIColor *)eva_greyColor {
    return [self colorWithHexValue:@"#6C6C6C"];
}

@end
