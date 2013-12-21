//
//  LaunchViewController.h
//  Run2Bart
//
//  Created by Pete Hodgson on 12/1/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NearestStationLocator.h"

@interface LaunchViewController : UIViewController<NearestStationLocatorDelegate>
@property (weak, nonatomic) IBOutlet UIView *locatingView;
@property (weak, nonatomic) IBOutlet UIButton *nearestStationBtn;
@property (weak, nonatomic) IBOutlet UIButton *chooseStationBtn;

+ (LaunchViewController *)newWithNearestStationLocator:(NearestStationLocator *)stationLocator;

@end
