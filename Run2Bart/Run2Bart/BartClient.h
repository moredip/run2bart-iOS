//
//  BartClient.h
//  Run2Bart
//
//  Created by Pete Hodgson on 4/1/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Station;

@protocol BartClient
- (void)fetchUpcomingDeparturesForStation:(Station *)station
                                  success:(void (^)(NSArray *departures))success
                                  failure:(void (^)(NSError *error))failure;
@end

@interface BartClient : NSObject<BartClient>

+ (BartClient *) forProductionEnv;

- (id)initWithBaseURL:(NSURL *)baseURL;

- (void)fetchUpcomingDeparturesForStation:(Station *)station
                                  success:(void (^)(NSArray *departures))success
                                  failure:(void (^)(NSError *error))failure;

@end
