//
//  LaunchViewController.m
//  Run2Bart
//
//  Created by Pete Hodgson on 12/1/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import "LaunchViewController.h"

#import "AppDelegate.h"
#import "StationsViewController.h"

@interface LaunchViewController ()
{
    NearestStationLocator *_stationLocator;
}

@property (weak, nonatomic) IBOutlet UIButton *chooseStationBtn;
@end

@implementation LaunchViewController

+ (LaunchViewController *)newWithNearestStationLocator:(NearestStationLocator *)stationLocator
{
    return [[self alloc] initWithNearestStationLocator:stationLocator];
}

- (id)initWithNearestStationLocator:(NearestStationLocator *)stationLocator{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _stationLocator = stationLocator;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Home";
    
//    self.chooseStationBtn.layer.borderWidth = 0.5f;
//    self.chooseStationBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    
//    [self prepareGeolocation];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTouchNearestStation:(id)sender {
}

- (IBAction)didTouchChooseStation:(id)sender {
    StationsViewController *nextVC = [[AppDelegate sharedInstance] createStationsViewController];
    [self.navigationController pushViewController:nextVC animated:YES];
}

//- (void)prepareGeolocation{
//    //	if( ![ CLLocationManager locationServicesEnabled] ){
//    //		// TODO: tell user location stuff not enabled
//    //		return;
//    //	}
//	
//	[_locationManager release];
//	_locationManager = [[CLLocationManager alloc] init];
//	_locationManager.delegate = self;
//	NSLog(@"looking up location...");
//	[_locationManager startUpdatingLocation];
//}

@end
