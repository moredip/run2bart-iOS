//
//  Station.m
//  Run2Bart
//
//  Created by Pete Hodgson on 3/28/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import "Station.h"
#import "UpcomingDeparture.h"

#import "AFJSONRequestOperation.h"

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
        _name = name;
		_abbr = abbr;
    }
    return self;    
}

- (NSURL *)urlForUpcomingDepartures{
    return [[NSURL URLWithString:@"http://dude-wheres-my-bart.heroku.com/stations/"] URLByAppendingPathComponent:self.abbr];
}

- (void)fetchUpcomingDeparturesAndOnSuccess:(void (^)(NSArray *departures))success
                                   failure:(void (^)(NSError *error))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self urlForUpcomingDepartures]];
    [request setValue:[NSString stringWithFormat:@"application/json"] forHTTPHeaderField:@"Accept"];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
        NSArray *upcomingDepartures = [UpcomingDeparture listOfUpcomingDepaturesfromJson:json];
        if( success )
            success(upcomingDepartures);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id json) {
        NSLog(@"Failed to fetch upcoming departures: %@", [error localizedDescription]);
        if( failure )
            failure(error);
    }];

    [operation start];
}

@end
