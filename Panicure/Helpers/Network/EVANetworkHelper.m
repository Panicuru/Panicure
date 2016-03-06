//
//  NetworkHelper.m
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//
#import <Parse/Parse.h>

#import "EVANetworkHelper.h"

@implementation EVANetworkHelper


+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EVANetworkHelper alloc] init];
    });
    return instance;
}

- (void)saveNewPanic:(PFObject *)panic completion:(void(^)(NSError *error))completion {
    
    PFObject *pfObject = (PFObject *)panic;
    [pfObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        completion(error);
    }];
}

@end
