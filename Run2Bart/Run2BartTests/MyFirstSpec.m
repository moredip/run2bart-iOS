#import "Kiwi.h"

SPEC_BEGIN(MyFirstSpec)
describe(@"Basic Arithmetic", ^{
    specify(^{
        [[theValue(12+1) should] equal:theValue(13)];
    });
});

SPEC_END