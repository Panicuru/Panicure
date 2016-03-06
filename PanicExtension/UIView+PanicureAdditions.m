//
//  UIView+PanicureAdditions.m
//  Panicure
//
//  Created by Vahan Harutyunyan on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

#import "UIView+PanicureAdditions.h"

@implementation UIView (PanicureAdditions)
@dynamic borderColor,borderWidth,cornerRadius;

-(void)setBorderColor:(UIColor *)borderColor{
    [self.layer setBorderColor:borderColor.CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
}
@end
