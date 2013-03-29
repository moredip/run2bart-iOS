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
        [stations addObject:[[Station alloc] initFromDictionary:rawStation]];
    }
    return stations;
}

- (id)initFromDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _name = [dict objectForKey:@"name"];
		_abbr = [dict objectForKey:@"abbr"];
    }
    return self;
}

@end
