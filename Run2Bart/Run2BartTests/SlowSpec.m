#import "Kiwi.h"

SPEC_BEGIN(SpecWhichGivesTheSimulatorAChanceToCatchUp)
describe(@"Wait a second", ^{
    it(@"gives pause",^{
        [NSThread sleepForTimeInterval:1.0];
    });
});

SPEC_END