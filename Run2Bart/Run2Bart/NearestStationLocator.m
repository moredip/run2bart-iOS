//
//  NearestStationLocator.m
//  Run2Bart
//
//  Created by Pete Hodgson on 12/9/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import "NearestStationLocator.h"

#define LOCATION_STALENESS_THRESHOLD (60*60) // 1 hour

@interface NearestStationLocator()
{
    CLLocationManager *_locationManager;
    NSArray *_stations;
}
@end

@implementation NearestStationLocator

- (id)initWithLocationManager:(CLLocationManager *)locationManager stationList:(NSArray *)stations
{
    self = [super init];
    if (self) {
        _locationManager = locationManager;
        _stations = [stations copy];
    }
    return self;
}

- (BOOL) startLocating{
    if( ![CLLocationManager locationServicesEnabled] )
        return NO;
    
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *mostRecentlyReportedLocation = locations[0];
    
    NSTimeInterval stalenessOfLocation = -[mostRecentlyReportedLocation.timestamp timeIntervalSinceNow];
	NSLog( @"location is %f seconds old", stalenessOfLocation );
	if( stalenessOfLocation > LOCATION_STALENESS_THRESHOLD ){
		NSLog(@"ignoring this location, it's too old");
		return;
	}
    
    NSArray *stationsSortedByDistance = [_stations sortedArrayUsingComparator: ^(Station *lhs, Station *rhs) {
		CLLocationDistance lhsDistance = [mostRecentlyReportedLocation distanceFromLocation:[(Station*)lhs location]];
		CLLocationDistance rhsDistance = [mostRecentlyReportedLocation distanceFromLocation:[(Station*)rhs location]];
		
		if( lhsDistance > rhsDistance ) {
			return (NSComparisonResult)NSOrderedDescending;
		}else if( lhsDistance < rhsDistance ) {
			return (NSComparisonResult)NSOrderedAscending;
		}else{
			return NSOrderedSame;
		}
	}];
    
    Station *nearestStation = stationsSortedByDistance[0];
    [self.delegate nearestStationLocator:self didLocateNearestStation:nearestStation];
}

@end
