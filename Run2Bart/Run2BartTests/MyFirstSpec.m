#import "Kiwi.h"

SPEC_BEGIN(MyFirstSpec)
describe(@"Basic Arithmetic", ^{
    it( @"adds 2 and 2", ^{
        [[theValue(2+2) should] equal:theValue(4)];
    });
});

SPEC_END