//
//  EVAXOREncrypt.m
//  Panicure
//
//  Created by Anya McGee on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVAXOREncrypt.h"
//#import "Panicure-Swift.h"

@implementation XOREncryption

+(NSString *) encryptDecrypt:(NSString *)input {
    unichar key[] = {"B", "A", "S", "I", "L"};
    NSMutableString *output = [[NSMutableString alloc] init];
    
    for(int i = 0; i < input.length; i++) {
        unichar c = [input characterAtIndex:i];
        c ^= key[i % sizeof(key)/sizeof(unichar)];
        [output appendString:[NSString stringWithFormat:@"%C", c]];
    }
    
    return output;
}

@end