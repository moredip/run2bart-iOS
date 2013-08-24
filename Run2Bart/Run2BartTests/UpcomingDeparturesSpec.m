#import "Kiwi.h"

#import "UpcomingDeparture.h"

SPEC_BEGIN(UpcomingDepartureSpec)
describe(@"[UpcomingDeparture etdToDisplay]", ^{
    it(@"is correct for an etd of 5",^{
        UpcomingDeparture *upcomingDeparture = [[UpcomingDeparture alloc] initWithDestinationName:@"blah"
                                                                                              etd:@(5)];
        [[[upcomingDeparture etdToDisplay] should] equal:@"5 mins"];
    });
});
SPEC_END