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
        UpcomingDeparture *departure = [[UpcomingDeparture alloc] initWithDestinationName:[rawDeparture objectForKey:@"dest_name"]
                                                                                      etd:[rawDeparture objectForKey:@"etd"]];
        [upcomingDepartures addObject:departure];
    }
    return upcomingDepartures;
}

- (id)initWithDestinationName:(NSString *)destinationName etd:(NSNumber *) etd
{
    self = [super init];
    if (self) {
        _etdInMinutes = [etd copy];
        _destinationName = [destinationName copy];
    }
    return self;
}

- (NSString *) etdToDisplay{
    if( [self.etdInMinutes isEqualToNumber:@(0)] ){
        return @"now";
    }else if( [self.etdInMinutes isEqualToNumber:@(1)] ){
        return @"1 min";
    }else{
        return [NSString stringWithFormat:@"%@ mins", self.etdInMinutes];
    }
}

@end
