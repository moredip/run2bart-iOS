#import "Kiwi.h"

#import "Station.h"

SPEC_BEGIN(StationSpec)
describe(@"Station", ^{
    
    it(@"loads from JSON correctly",^{
        //////////////////
        // Arrange
        NSArray *rawStations = @[
            @{@"abbr":@"s1",@"name":@"station one", @"lat":@12.3, @"long":@4.56},
            @{@"abbr":@"s2",@"name":@"station two", @"lat":@102.3, @"long":@40.56},
        ];
        
        //////////////////
        // Act
        NSArray *stations = [Station loadStations:rawStations];
        
        
        //////////////////
        // Assert
        [[theValue(stations.count) should] equal:theValue(2)];
        
        Station *firstStation = stations[0];
        Station *secondStation = stations[1];
        
        [[firstStation.abbr should] equal:@"s1"];
        [[firstStation.name should] equal:@"station one"];
        [[theValue(firstStation.coords.latitude) should] equal:theValue(12.3)];
//        [[[[[stations[0] location] coordinate] latitude] should] equal:theValue(12.3)];
        
        [[[stations[1] abbr] should] equal:@"s2"];
        [[[stations[1] name] should] equal:@"station two"];
    });
});

SPEC_END