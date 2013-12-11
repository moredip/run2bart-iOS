//
//  Station.m
//  Run2Bart
//
//  Created by Pete Hodgson on 3/28/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import "Station.h"

@implementation Station

+ (NSArray *)loadStations:(NSArray *)rawStations
{
    NSMutableArray *stations = [NSMutableArray array];
    for(NSDictionary *rawStation in rawStations){
        NSNumber *latitude = rawStation[@"lat"];
        NSNumber *longitude = rawStation[@"long"];
        CLLocationCoordinate2D coords = {latitude.doubleValue,longitude.doubleValue};
        Station *station = [[Station alloc] initWithName:rawStation[@"name"]
                                                    abbr:rawStation[@"abbr"]
                                                  coords:coords];
        [stations addObject:station];
    }
    return stations;
}

- (id)initWithName:(NSString *)name abbr:(NSString *)abbr coords:(CLLocationCoordinate2D)coords
{
    
    self = [super init];
    if (self) {
        _name = [name copy];
		_abbr = [abbr copy];
        _coords = coords;
    }
    return self;    
}

- (CLLocation *)location
{
    return [[CLLocation alloc] initWithLatitude:_coords.latitude longitude:_coords.longitude];
}

@end
