#import "Kiwi.h"

#import "NearestStationLocator.h"

SPEC_BEGIN(NearestStationLocatorSpec)
describe(@"NearestStationLocator", ^{
    __block id mockLocationManager;
    __block NearestStationLocator *locator;
    
    beforeEach(^{
        mockLocationManager = [KWMock mockForClass:[CLLocationManager class]];
        locator = [[NearestStationLocator alloc] initWithLocationManager:mockLocationManager stationList:@[]];
    });
    
    describe(@"starting locating", ^{
        it(@"registers as the location manager delegate and requests location updating to start", ^{
            [[[mockLocationManager should] receive] setDelegate:locator];
            [[[mockLocationManager should] receive] startUpdatingLocation];
            
            [locator startLocating];
        });
        
        it( @"doesn't do anything and returns false if the location manager reports that location services are turned off", ^{
            [CLLocationManager stub:@selector(locationServicesEnabled) andReturn:theValue(NO)];
            
            [[[mockLocationManager shouldNot] receive] startUpdatingLocation];
            
            BOOL result = [locator startLocating];
            [[theValue(result) should] beFalse];
        });
    });
    
    
    describe(@"when asked to stop locating", ^{
        it(@"should tell the location manager to stop updates", ^{
            [[[mockLocationManager should] receive] stopUpdatingLocation];

             [locator stopLocating];
         });
     });
    
    describe(@"when location updates come in", ^{
        __block NSArray *stations;
        __block id locatorDelegateSpy;
        
        beforeEach(^{
            stations = @[
                          [[Station alloc] initWithName:@"a" abbr:@"a" coords:(CLLocationCoordinate2D){0.0,0.0}],
                          [[Station alloc] initWithName:@"a" abbr:@"a" coords:(CLLocationCoordinate2D){2.0,0.0}],
                          [[Station alloc] initWithName:@"a" abbr:@"a" coords:(CLLocationCoordinate2D){0.0,-4.0}]
                          ];
            locator = [[NearestStationLocator alloc] initWithLocationManager:mockLocationManager stationList:stations];
            
            locatorDelegateSpy = [KWMock mockForProtocol:@protocol(NearestStationLocatorDelegate)];
            locator.delegate = locatorDelegateSpy;
        });
        
        it( @"calls its delegate, reporting the closest station", ^{
            [[[locatorDelegateSpy should] receive] nearestStationLocator:locator didLocateNearestStation:stations[1]];
            
            NSArray *locationUpdatesToReport = @[
                                                 [[CLLocation alloc] initWithLatitude:1.5 longitude:0.0]
                                                 ];
            [locator locationManager:nil didUpdateLocations:locationUpdatesToReport];
        });
        
        it( @"uses the most recent geolocation reported", ^{
            [[[locatorDelegateSpy should] receive] nearestStationLocator:locator didLocateNearestStation:stations[2]];
            
            NSArray *locationUpdatesToReport = @[
                                                 [[CLLocation alloc] initWithLatitude:2.0 longitude:0.1],
                                                 [[CLLocation alloc] initWithLatitude:0.0 longitude:-4.1]
                                                 ];
            [locator locationManager:nil didUpdateLocations:locationUpdatesToReport];
        });
        
        it( @"ignores location updates older than an hour", ^{
            
            CLLocation *locationFromJustOverAnHourAgo = [[CLLocation alloc] initWithCoordinate:(CLLocationCoordinate2D){0.0,0.0}
                                                                                     altitude:0.0
                                                                           horizontalAccuracy:5.0
                                                                             verticalAccuracy:5.0
                                                                                     timestamp:[NSDate dateWithTimeIntervalSinceNow:-(61*60)]];
            
            [locator locationManager:nil didUpdateLocations:@[locationFromJustOverAnHourAgo]];
            
            [[locatorDelegateSpy shouldNot] receive:@selector(nearestStationLocator:didLocateNearestStation:)];
        });
        
    });

    
    // TODO: define authorization to geolocate being granted
});
SPEC_END