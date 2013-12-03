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
@property (weak, nonatomic) IBOutlet UIButton *chooseStationBtn;

@end

@implementation LaunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
