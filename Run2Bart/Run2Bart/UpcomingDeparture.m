//
//  UpcomingDepartures.m
//  Run2Bart
//
//  Created by Pete Hodgson on 3/29/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import "UpcomingDeparture.h"

@implementation UpcomingDeparture


+(NSArray *)listOfUpcomingDepaturesfromJson:(NSArray *)rawJson;
{
    NSMutableArray *upcomingDepartures = [NSMutableArray array];
    for(NSDictionary *rawDeparture in rawJson){
        [upcomingDepartures addObject:[[UpcomingDeparture alloc] initFromJson:rawDeparture]];
    }
    return upcomingDepartures;
}

- (id)initFromJson:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _etdInMinutes = [dict objectForKey:@"etd"];
        _destinationName = [dict objectForKey:@"dest_name"];
    }
    return self;
}

@end
