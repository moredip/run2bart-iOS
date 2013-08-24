#import "Kiwi.h"

#import "UpcomingDeparturesViewController.h"
#import "Station.h"
#import "BartClient.h"
#import "UpcomingDeparture.h"


SPEC_BEGIN(UpcomingDeparturesViewControllerSpec)
describe( @"UpcomingDeparturesViewController ", ^{
    it( @"has the station's name as the title", ^{
        // Given
        Station *theStation =
        [[Station alloc] initWithName:@"station name"
                                 abbr:@"station-abbr"];
        UpcomingDeparturesViewController *theDeparturesVC =
        [[UpcomingDeparturesViewController alloc] initForStation:theStation];
        
        // Then
        [[theDeparturesVC.title should] equal:@"station name"];
    });
});

describe(@"rendering departures", ^{
    it( @"renders a table view cell for each departure", ^{
        // Given
        UITableView *ignoredTableView = nil;
        Station *someStation =
            [[Station alloc] initWithName:@"station name"
                                     abbr:@"station-abbr"];
        UpcomingDeparturesViewController *departuresVC =
        [[UpcomingDeparturesViewController alloc] initForStation:someStation];
        
        NSArray *departures = @[
                                [[UpcomingDeparture alloc] initWithDestinationName:@"dest 1" etd:@(0)],
                                [[UpcomingDeparture alloc] initWithDestinationName:@"dest 2" etd:@(1)],
                                [[UpcomingDeparture alloc] initWithDestinationName:@"dest 3" etd:@(2)]
                                ];
        departuresVC.departures = departures;
        
        // When
        NSInteger numSections =
            [departuresVC numberOfSectionsInTableView:ignoredTableView];
        NSInteger numRows =
            [departuresVC tableView:ignoredTableView numberOfRowsInSection:0];
        
        // Then
        [[theValue(numSections) should] equal:theValue(1)];
        [[theValue(numRows) should] equal:theValue(3)];
    });
});
SPEC_END