//
//  NearestStationLocator.h
//  Run2Bart
//
//  Created by Pete Hodgson on 12/9/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface NearestStationLocator : NSObject

- (id)initWithLocationManager:(CLLocationManager *)locationManager;

- (void)startLocating;

@end
