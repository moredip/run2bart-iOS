//
//  NearestStationLocator.m
//  Run2Bart
//
//  Created by Pete Hodgson on 12/9/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import "NearestStationLocator.h"

@interface NearestStationLocator()
{
    CLLocationManager *_locationManager;
}
@end

@implementation NearestStationLocator

- (id)initWithLocationManager:(CLLocationManager *)locationManager
{
    self = [super init];
    if (self) {
        _locationManager = locationManager;
    }
    return self;
}

- (void)startLocating{
    [_locationManager startUpdatingLocation];
}

@end
