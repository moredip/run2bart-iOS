//
//  BartClient.m
//  Run2Bart
//
//  Created by Pete Hodgson on 4/1/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import "BartClient.h"

#import "Station.h"
#import "UpcomingDeparture.h"

@interface BartClient()
@property(nonatomic,retain) AFHTTPClient *api;
@end

@implementation BartClient

+ (BartClient *) forProductionEnv
{
    return [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://dude-wheres-my-bart.heroku.com/"]];
}

- (id)initWithBaseURL:(NSURL *)baseURL
{
    self = [super init];
    if (self) {
        self.api = [AFHTTPClient clientWithBaseURL:baseURL];
        [self.api setDefaultHeader:@"Accept" value:@"application/json"];
        [self.api registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    return self;
}

- (void)fetchUpcomingDeparturesForStation:(Station *)station
                                  success:(void (^)(NSArray *departures))success
                                  failure:(void (^)(NSError *error))failure
{
    NSString *path = [@"stations" stringByAppendingPathComponent:station.abbr];
    
    [self.api getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id json) {
        NSArray *upcomingDepartures = [UpcomingDeparture listOfUpcomingDepaturesfromJson:json];
        if( success )
            success(upcomingDepartures);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to fetch upcoming departures: %@", [error localizedDescription]);
        if( failure )
            failure(error);
    }];
}


@end
