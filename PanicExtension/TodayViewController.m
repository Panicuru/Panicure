//
//  TodayViewController.m
//  PanicureExtension
//
//  Created by Vahan Harutyunyan on 2016-03-05.
//  Copyright © 2016 Panicuru. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <CoreLocation/CoreLocation.h>

@interface TodayViewController () <NCWidgetProviding,CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestAlwaysAuthorization];
    }
    
    [_locationManager startMonitoringSignificantLocationChanges];
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
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    if (locations.lastObject != nil) {
        self.currentLocation = locations.lastObject;
    } else {
        self.currentLocation = manager.location;
    }
}

@end
