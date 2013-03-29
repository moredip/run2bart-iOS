#import "Kiwi.h"

#import "Station.h"

SPEC_BEGIN(StationSpec)
describe(@"Station", ^{
    
    it(@"loads from a dictionary correctly",^{
        NSDictionary *dict = @{@"abbr":@"station abbr",@"name":@"station name"};
        Station *station = [[Station alloc] initFromDictionary:dict];

        [[station.abbr should] equal:@"station abbr"];
        [[station.name should] equal:@"station name"];
    });
});

SPEC_END