#import "Kiwi.h"

#import "LaunchViewController.h"

SPEC_BEGIN(LaunchViewControllerSpec)
describe(@"LaunchViewController", ^{
    
    it( @"should be creatable", ^{
        LaunchViewController *launchViewController = [[LaunchViewController alloc] init];
        [launchViewController shouldNotBeNil];
    });
    
    it( @"should be creatable via a factory method", ^{
        LaunchViewController *launchViewController = [LaunchViewController newWithNearestStationLocator:nil];
        [launchViewController shouldNotBeNil];
    });
    
    it( @"registers as a delegate to its station locator", ^{
        id mockStationLocator = [KWMock mockForClass:[NearestStationLocator class]];
        
        [[mockStationLocator should] receive:@selector(setDelegate:)];
        LaunchViewController *launchViewController = [LaunchViewController newWithNearestStationLocator:mockStationLocator];
    });
    
    // it starts up station locating when the view appears
    
    // it handles inability to locate
    // - no hardware (hide UI)
    // - not yet authorized (tap here to authorize)
    // - explicitly banned (tap here to re-authorize)

    // it stops locating once the view disappears
    
    // it handles nearest station event by updating UI
    
    // it handles tap on Nearest button by displaying deets for that station
    
    // it handles tap on other button

});

SPEC_END