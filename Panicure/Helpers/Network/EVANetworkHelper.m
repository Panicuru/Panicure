//
//  NetworkHelper.m
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//
#import <Parse/Parse.h>
#import <Bolts/Bolts.h>

#import "EVANetworkHelper.h"

#import "EVAXOREncrypt.h"

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
    
    // Encrypt all the string properties
    
    PFObject *pfObject = (PFObject *)panic;
    _lastPanic = panic;
    PFUser *user = [pfObject valueForKey:@"user"];
//    [pfObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        completion(error);
//    }];
    
    [[[pfObject saveInBackground] continueWithBlock:^id _Nullable(BFTask<NSNumber *> * _Nonnull task) {
        PFQuery *pushQuery = [PFInstallation query];
        [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
        
        // Send push notification to query
        NSString* pushText = [NSString stringWithFormat: @"%@ has panicked at '%@' ", user.email, [XOREncryption encryptDecrypt:[pfObject valueForKey:@"locationName"]]];
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              pushText, @"alert",
                              @"Increment", @"badge",
                               user.email,@"userEmail",
                               user.objectId,@"userId",
                              nil];
        
        return [PFPush sendPushDataToQueryInBackground:pushQuery withData:data];
    }] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        
        completion(task.error);
        
        return nil;
    }];
}

- (void)saveFrontCameraImage:(UIImage *)image toPanic:(PFObject *)panic {
    // Save the image file
    [[self saveImage:image] continueWithBlock:^id _Nullable(BFTask<PFFile *> * _Nonnull task) {
        
        if (task.error) {
            return nil;
        }
        
        [panic addObject:task.result forKey:@"frontCameraImages"];
        return [panic saveInBackground];
    }];
}
- (void)saveBackCameraImage:(UIImage *)image toPanic:(PFObject *)panic {
    // Save the image file
    [[self saveImage:image] continueWithBlock:^id _Nullable(BFTask<PFFile *> * _Nonnull task) {
        
        if (task.error) {
            return nil;
        }
        
        [panic addObject:task.result forKey:@"backCameraImages"];
        return [panic saveInBackground];
    }];
}


- (BFTask *)saveImage:(UIImage *)image {
    
    // Create a new empty task
    BFTaskCompletionSource *currentTask = [BFTaskCompletionSource taskCompletionSource];
    
    // Create a pffile and save it
    PFFile *file = [PFFile fileWithData:UIImageJPEGRepresentation(image, 1.0)];
    [[file saveInBackground] continueWithBlock:^id _Nullable(BFTask<NSNumber *> * _Nonnull task) {
        
        if (task.error) {
            [currentTask setError:task.error];
        } else {
            [currentTask setResult:file];
        }
        
        return nil;
    }];
    
    return currentTask.task;
}



#pragma mark -
#pragma mark - Utility

+ (void)createRole:(NSString *)roleName {
    PFACL *roleACL = [PFACL ACL];
    [roleACL setPublicReadAccess:YES];
    PFRole *role = [PFRole roleWithName:roleName acl:roleACL];
    [role.users addObject:[PFUser currentUser]];
    [[role saveInBackground] continueWithBlock:^id _Nullable(BFTask<NSNumber *> * _Nonnull task) {
        if (task.error) {
//            errorAlert(@"Save Role", task.error);
        } else {
            NSLog(@"SAved");
        }
        return nil;
    }];
}

+ (void)addUserToFirstRole:(NSString *)username {
    /// Add a user to admin
    __block PFRole *role;
    
    // Get the role
    PFQuery *roleQuery = [PFRole query];
    [[[[roleQuery findObjectsInBackground] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        if (task.error) {
            NSLog(@"role error: %@", task.error);
            return nil;
        }
        role = task.result[1];
        
        // Get the user
        PFQuery *query = [PFUser query];
        [query whereKey:@"email" equalTo:username];
        return [query getFirstObjectInBackground];

    }]continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        
        if (task.error) {
            return nil;
        }
        
        PFUser *user = task.result;
        [role.users addObject:user];
        return [role saveInBackground];
    }] continueWithBlock:^id _Nullable(BFTask<NSNumber *> * _Nonnull task) {
        if (task.error) {
            NSLog(@"error: %@", task.error);
        } else {
            NSLog(@"SAved");
        }
        return nil;
    }];

}

@end
