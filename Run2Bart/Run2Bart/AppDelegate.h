//
//  AppDelegate.h
//  Run2Bart
//
//  Created by Pete Hodgson on 3/28/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BartClient;
@class StationsViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (readonly) BartClient *bartClient;

+(AppDelegate *)sharedInstance;

- (StationsViewController *)createStationsViewController;
- (void) setApiBaseUrl:(NSString *)newBaseUrl;

@end
