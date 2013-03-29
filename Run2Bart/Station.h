//
//  Station.h
//  Run2Bart
//
//  Created by Pete Hodgson on 3/28/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station : NSObject
@property (nonatomic,readonly) NSString *abbr;
@property (nonatomic,readonly) NSString *name;

+ (NSArray *)loadStations:(NSArray *)rawStations;
- (id)initFromDictionary:(NSDictionary *)dict;

@end


