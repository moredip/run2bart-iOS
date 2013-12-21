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
#import "UpcomingDeparturesViewController.h"

@interface LaunchViewController ()
{
    NearestStationLocator *_stationLocator;
    Station *_mostRecentlyReportedNearestStation;
    BOOL haveNotAnimatedInitialLocatingViewAway;
}
@end

@implementation LaunchViewController

+ (LaunchViewController *)newWithNearestStationLocator:(NearestStationLocator *)stationLocator
{
    return [[self alloc] initWithNearestStationLocator:stationLocator];
}

- (id)initWithNearestStationLocator:(NearestStationLocator *)stationLocator{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        haveNotAnimatedInitialLocatingViewAway = YES;
        _mostRecentlyReportedNearestStation = nil;
        
        _stationLocator = stationLocator;
        _stationLocator.delegate = self;
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
    
    [_stationLocator startLocating];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;

    [_stationLocator stopLocating];
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
    if( _mostRecentlyReportedNearestStation ){
        UpcomingDeparturesViewController *nextVC = [[UpcomingDeparturesViewController alloc]initForStation:_mostRecentlyReportedNearestStation];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (IBAction)didTouchChooseStation:(id)sender {
    StationsViewController *nextVC = [[AppDelegate sharedInstance] createStationsViewController];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void) animateLocatingUIAway{
	CGPoint newCenter = CGPointMake(self.locatingView.center.x, self.locatingView.center.y-120);
	[UIView animateWithDuration:0.3
					 animations:^{
						 self.locatingView.center = newCenter;
						 for (UIView *subview in [self.locatingView subviews]) {
							 if( ![subview isKindOfClass:[UIImageView class]] ) //don't fade out the background image
								 subview.alpha = 0.0;
						 }
					 }
					 completion:^(BOOL finished){
                         //						 [_locatingView setHidden:YES];
                         //						 [_locatingView setAlpha:1.0];
					 }];
}


#pragma -
#pragma NearestStationLocatorDelegate impl

- (void) nearestStationLocator:(NearestStationLocator *)locator didLocateNearestStation:(Station *)station{

    _mostRecentlyReportedNearestStation = station;
    [self.nearestStationBtn setTitle:_mostRecentlyReportedNearestStation.name forState:UIControlStateNormal];
    
    if( haveNotAnimatedInitialLocatingViewAway )
    {
        [self animateLocatingUIAway];
        haveNotAnimatedInitialLocatingViewAway = NO;
    }
}

@end
