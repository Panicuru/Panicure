//
//  NetworkHelper.h
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFObject;

NS_ASSUME_NONNULL_BEGIN

@interface EVANetworkHelper : NSObject

+ (instancetype)sharedInstance;

- (void)saveNewPanic:(PFObject *)panic completion:(void(^)(NSError * _Nullable error))completion;

+ (void)createRole:(NSString *)roleName;

+ (void)addUserToFirstRole:(NSString *)username;

@end

NS_ASSUME_NONNULL_END