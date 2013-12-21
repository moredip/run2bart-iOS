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
    
    it( @"wires up outlets", ^{
        LaunchViewController *launchViewController = [LaunchViewController newWithNearestStationLocator:nil];
        [launchViewController view];
        [launchViewController.locatingView shouldNotBeNil];
    });
    
    it( @"registers as a delegate to its station locator", ^{
        NearestStationLocator *stationLocator = [[NearestStationLocator alloc] initWithLocationManager:nil stationList:nil];
        LaunchViewController *launchViewController = [LaunchViewController newWithNearestStationLocator:stationLocator];
        id stationLocatorDelegate = stationLocator.delegate;
        [[stationLocatorDelegate should] equal:launchViewController];
    });
    
    it(@"starts looking for the nearest station as the view appears", ^{
        id mockNearestStationLocator = [KWMock mockForClass:[NearestStationLocator class]];
        [mockNearestStationLocator stub:@selector(setDelegate:)];
        LaunchViewController *launchViewController = [LaunchViewController newWithNearestStationLocator:mockNearestStationLocator];
        
        [[mockNearestStationLocator should] receive:@selector(startLocating) andReturn:theValue(NO)];
        
        [launchViewController viewWillAppear:YES];
    });
    
    it(@"stops looking for the nearest station as the view disappears", ^{
        id mockNearestStationLocator = [KWMock mockForClass:[NearestStationLocator class]];
        [mockNearestStationLocator stub:@selector(setDelegate:)];
        LaunchViewController *launchViewController = [LaunchViewController newWithNearestStationLocator:mockNearestStationLocator];
        
        [[mockNearestStationLocator should] receive:@selector(stopLocating)];
        
        [launchViewController viewWillDisappear:YES];
    });
    
    describe( @"handling nearest station updates", ^{
        __block Station *nearestStation;
        __block LaunchViewController *launchViewController;
        
        beforeEach(^{
            nearestStation = [[Station alloc] initWithName:@"station name"
                                                               abbr:@"blah"
                                                             coords:(CLLocationCoordinate2D){0.0,0.0}];
            
            launchViewController = [LaunchViewController newWithNearestStationLocator:nil];
            [launchViewController view];
        });

        
        it(@"raises the locating view", ^{
            [[theValue(launchViewController.locatingView.frame.origin.y) should] equal:theValue(0.0)];
            
            [launchViewController nearestStationLocator:nil didLocateNearestStation:nearestStation];
            
            [[theValue(launchViewController.locatingView.frame.origin.y) should] beLessThan:theValue(0.0)];
        });
        
        it(@"doesn't repeatedly raise the locating view as it gets nearest station updates", ^{
            [launchViewController nearestStationLocator:nil didLocateNearestStation:nearestStation];
            [launchViewController nearestStationLocator:nil didLocateNearestStation:nearestStation];
            [launchViewController nearestStationLocator:nil didLocateNearestStation:nearestStation];
            [launchViewController nearestStationLocator:nil didLocateNearestStation:nearestStation];
            [launchViewController nearestStationLocator:nil didLocateNearestStation:nearestStation];
            // part of the locating view should still be in frame
            [[theValue(CGRectGetMaxY(launchViewController.locatingView.frame)) should] beGreaterThan:theValue(0.0)];
        });
        
        it(@"updates the nearest station button with the name of the station", ^{
            [launchViewController nearestStationLocator:nil didLocateNearestStation:nearestStation];
            [[(launchViewController.nearestStationBtn.titleLabel.text) should] equal:nearestStation.name];
        });
        
        it(@"shows the most recent nearest station when you tap the nearest station button", ^{
            // Given
            LaunchViewController *launchViewController = [LaunchViewController newWithNearestStationLocator:nil];
            [launchViewController view];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:launchViewController];
            
            // When
            [launchViewController nearestStationLocator:nil didLocateNearestStation:nearestStation];
            [[launchViewController nearestStationBtn] sendActionsForControlEvents:UIControlEventTouchUpInside];
            
            // Then
            [[theValue(navController.viewControllers.count) should] equal:theValue(2)];
            [[NSStringFromClass(navController.visibleViewController.class) should] equal:@"UpcomingDeparturesViewController"];
            [[navController.visibleViewController.title should] equal:nearestStation.name];
        });
    });
    
    it(@"displays the station chooser when you tap the 'Choose station' button", ^{
        // Given
        LaunchViewController *launchViewController = [LaunchViewController newWithNearestStationLocator:nil];
        [launchViewController view];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:launchViewController];

        // When
        [[launchViewController chooseStationBtn] sendActionsForControlEvents:UIControlEventTouchUpInside];

        // Then
        [[theValue(navController.viewControllers.count) should] equal:theValue(2)];
        [[NSStringFromClass(navController.visibleViewController.class) should] equal:@"StationsViewController"];
    });
    
    
    // it handles inability to locate
    // - no hardware (hide UI)
    // - not yet authorized (tap here to authorize)
    // - explicitly banned (tap here to re-authorize)
});

SPEC_END