//
//  TodayViewController.m
//  PanicureExtension
//
//  Created by Vahan Harutyunyan on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//
#import <Parse/Parse.h>
#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <CoreLocation/CoreLocation.h>
#import "UIColor+PanicureAdditions.h"

#import "PanicExtension-Swift.h"

@interface TodayViewController () <NCWidgetProviding,CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@property (strong, nonatomic) IBOutlet UIButton* panicButton;
@property (strong, nonatomic) IBOutlet UIButton* signupButton;

///
@property (strong, nonatomic) EVALocationHelper *locationHelper;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Parse enableDataSharingWithApplicationGroupIdentifier:@"group.com.panicuru"
                                     containingApplication:@"com.panicuru.Panicure"];
    // Setup Parse
    [EVAParseHelper start];
    if([PFUser currentUser]){
        self.panicButton.hidden = NO;
        self.signupButton.hidden = YES;
    }else{
        self.panicButton.hidden = YES;
        self.signupButton.hidden = NO;
    }
    
    
    
    
    self.locationHelper = [[EVALocationHelper alloc] init];
    [_locationHelper requestLocation:^(CLLocation * _Nullable location, NSError * _Nullable error) {
        
    }];
    
    
    
    // Do any additional setup after loading the view from its nib.
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestAlwaysAuthorization];
    }
    
    [_locationManager startMonitoringSignificantLocationChanges];
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.panicButton setTitle:@"Panic Now" forState:UIControlStateNormal];
    [self.panicButton setBackgroundColor:[UIColor eva_mainRedColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}
- (IBAction)panicAction:(id)sender {
    if(!self.currentLocation){
        self.currentLocation = self.locationManager.location;
    }
    
    NSLog(@"%@", self.currentLocation.description);
    
    [self.panicButton setTitle:@"Sending..." forState:UIControlStateNormal];
    [self.panicButton setBackgroundColor:[UIColor eva_greyColor]];
    
    [EVAPanicHelper startPanicingWithCompletion:^(NSError * _Nullable error) {
        if (error) {
            // Handle error
            return;
        }
        [self.panicButton setTitle:@"Sent" forState:UIControlStateNormal];
        [self.panicButton setBackgroundColor:[UIColor clearColor]];
        
        NSURL *url = [NSURL URLWithString:@"panicure://"];
        [self.extensionContext openURL:url completionHandler:nil];
        // Panic Successful
    }];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    if (locations.lastObject != nil) {
        self.currentLocation = locations.lastObject;
    } else {
        self.currentLocation = manager.location;
    }
}

- (IBAction)signupAction:(id)sender {
    NSURL *url = [NSURL URLWithString:@"panicure://"];
    [self.extensionContext openURL:url completionHandler:nil];
}

@end
