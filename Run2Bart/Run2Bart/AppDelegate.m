//
//  AppDelegate.m
//  Run2Bart
//
//  Created by Pete Hodgson on 3/28/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "AppDelegate.h"

#import "LaunchViewController.h"
#import "StationsViewController.h"
#import "Station.h"
#import "BartClient.h"

@interface AppDelegate()
@end

@implementation AppDelegate

+(AppDelegate *)sharedInstance{
    return [[UIApplication sharedApplication] delegate];
}

- (void) setApiBaseUrl:(NSString *)newBaseUrl{
    _bartClient = [[BartClient alloc] initWithBaseURL:[NSURL URLWithString:newBaseUrl]];
}

- (StationsViewController *) createStationsViewController{
    StationsViewController *stationsVC = [[StationsViewController alloc] init];
    stationsVC.stations = [self loadStations];
    return stationsVC;
}

- (NSArray *) loadStations{
	NSString *file = [[NSBundle mainBundle] pathForResource:@"stations" ofType:@"json"];
	NSData *data = [NSData dataWithContentsOfFile:file];
	NSArray *rawStations = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    return [Station loadStations:rawStations];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _bartClient = [BartClient forProductionEnv];
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    NSArray *stations = [self loadStations];
    
    NearestStationLocator *stationLocator = [[NearestStationLocator alloc] initWithLocationManager:locationManager
                                                                                       stationList:stations];

    LaunchViewController *launchVC = [LaunchViewController newWithNearestStationLocator:stationLocator];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:launchVC];
    self.navController.navigationBar.tintColor = BART_BLUE;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
