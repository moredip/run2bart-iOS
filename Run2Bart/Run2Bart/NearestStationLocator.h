//
//  NearestStationLocator.h
//  Run2Bart
//
//  Created by Pete Hodgson on 12/9/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "Station.h"

@class NearestStationLocator;


@protocol  NearestStationLocatorDelegate
- (void) nearestStationLocator:(NearestStationLocator *)locator didLocateNearestStation:(Station *)station;
@end


@interface NearestStationLocator : NSObject<CLLocationManagerDelegate>

@property (nonatomic,assign) id<NearestStationLocatorDelegate> delegate;

- (id)initWithLocationManager:(CLLocationManager *)locationManager stationList:(NSArray *)stations;

- (BOOL)startLocating;

@end
