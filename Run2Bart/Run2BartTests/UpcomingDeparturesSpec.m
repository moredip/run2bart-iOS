#import "Kiwi.h"

#import "UpcomingDeparture.h"

SPEC_BEGIN(UpcomingDepartureSpec)
describe(@"[UpcomingDeparture etdToDisplay]", ^{
    it(@"is correct for an etd of 5",^{
        UpcomingDeparture *upcomingDeparture = [[UpcomingDeparture alloc] initWithDestinationName:@"blah"
                                                                                              etd:@(5)];
        [[[upcomingDeparture etdToDisplay] should] equal:@"5 mins"];
    });
    
    it(@"is correct for an etd of 1",^{
        UpcomingDeparture *upcomingDeparture = [[UpcomingDeparture alloc] initWithDestinationName:@"blah"
                                                                                              etd:@(1)];
        [[[upcomingDeparture etdToDisplay] should] equal:@"1 min"];
    });
    
    it(@"is correct for an etd of 0",^{
        UpcomingDeparture *upcomingDeparture = [[UpcomingDeparture alloc] initWithDestinationName:@"blah"
                                                                                              etd:@(0)];
        [[[upcomingDeparture etdToDisplay] should] equal:@"now"];
    });
});
SPEC_END