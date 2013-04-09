//
//  UpcomingDepartures.h
//  Run2Bart
//
//  Created by Pete Hodgson on 3/29/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpcomingDeparture : NSObject
@property (nonatomic,readonly) NSString *destinationName;
@property (nonatomic,readonly) NSNumber *etdInMinutes;

+(NSArray *)listOfUpcomingDepaturesfromJson:(NSArray *)rawJson;
- (id)initWithDestinationName:(NSString *)destinationName etd:(NSNumber *) etd;
- (NSString *) etdToDisplay;
@end
