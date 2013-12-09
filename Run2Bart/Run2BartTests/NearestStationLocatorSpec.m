#import "Kiwi.h"

#import "NearestStationLocator.h"

SPEC_BEGIN(NearestStationLocatorSpec)
describe(@"NearestStationLocator", ^{
    it(@"starts up geolocation", ^{
        id mockLocationManager = [KWMock mockForClass:[CLLocationManager class]];
        NearestStationLocator *locator = [[NearestStationLocator alloc] initWithLocationManager:mockLocationManager];
        
        [[mockLocationManager should] receive:@selector(startUpdatingLocation)
                               andReturn:nil];
        
        [locator startLocating];
    });
});
SPEC_END