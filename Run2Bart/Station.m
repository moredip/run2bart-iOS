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
        Station *station = [[Station alloc] initWithName:[rawStation objectForKey:@"name"]
                                                    abbr:[rawStation objectForKey:@"abbr"]];
        [stations addObject:station];
    }
    return stations;
}

- (id)initWithName:(NSString *)name abbr:(NSString *)abbr
{
    self = [super init];
    if (self) {
        _name = [name copy];
		_abbr = [abbr copy];
    }
    return self;    
}

@end
