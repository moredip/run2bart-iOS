#import "Kiwi.h"

#import "Station.h"

SPEC_BEGIN(StationSpec)
describe(@"Station", ^{
    
    it(@"loads from JSON correctly",^{
        //////////////////
        // Arrange
        NSArray *rawStations = @[
            @{@"abbr":@"s1",@"name":@"station one"},
            @{@"abbr":@"s2",@"name":@"station two"},
        ];
        
        //////////////////
        // Act
        NSArray *stations = [Station loadStations:rawStations];
        
        
        //////////////////
        // Assert
        [[theValue(stations.count) should] equal:theValue(2)];
        
        [[[stations[0] abbr] should] equal:@"s1"];
        [[[stations[0] name] should] equal:@"station one"];
        [[[stations[1] abbr] should] equal:@"s2"];
        [[[stations[1] name] should] equal:@"station two"];
    });
});

SPEC_END