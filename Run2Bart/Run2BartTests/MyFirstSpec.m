#import "Kiwi.h"

SPEC_BEGIN(MyFirstSpec)
describe(@"Basic Arithmetic", ^{
    specify(^{
        [[theValue(2+2) should] equal:theValue(4)];
    });
});

SPEC_END