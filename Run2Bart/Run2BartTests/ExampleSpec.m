#import "Kiwi.h"

SPEC_BEGIN(ExampleSpec)
describe(@"Basic Arithmetic", ^{
    it(@"can increment 12",^{
        [[theValue(12+1) should] equal:theValue(13)];
    });
});

SPEC_END