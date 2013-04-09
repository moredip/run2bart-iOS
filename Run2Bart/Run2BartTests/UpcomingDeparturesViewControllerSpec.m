#import "Kiwi.h"

#import "UpcomingDeparturesViewController.h"
#import "Station.h"
#import "BartClient.h"
#import "UpcomingDeparture.h"

SPEC_BEGIN(UpcomingDeparturesViewControllerSpec)
describe( @"UpcomingDeparturesViewController ", ^{
    __block Station *station;
    __block UpcomingDeparturesViewController *departuresVC;
    
    beforeEach(^{
        station = [[Station alloc] initWithName:@"station name" abbr:@"station-abbr"];
        departuresVC = [[UpcomingDeparturesViewController alloc] initForStation:station];
    });

    describe(@"loading upcoming departures", ^{        
        it( @"asks the api client to load the station's departures", ^{
            id mockBartClient = [KWMock mockForClass:[BartClient class]];
            departuresVC.bartClient = mockBartClient;
            
            [[mockBartClient should] receive:@selector(fetchUpcomingDeparturesForStation:success:failure:)
                                   andReturn:nil];
            
            //TODO: check arguments passed into the client
            
            [departuresVC viewWillAppear:YES];
        });
    });

    describe(@"rendering departures", ^{
        it( @"renders the destination name", ^{
            NSArray *departures = @[
                [[UpcomingDeparture alloc] initWithDestinationName:@"dest 1" etd:@(0)],
                [[UpcomingDeparture alloc] initWithDestinationName:@"dest 2" etd:@(1)],
                [[UpcomingDeparture alloc] initWithDestinationName:@"dest 3" etd:@(2)]
            ];
            departuresVC.departures = departures;
            
            UITableViewCell *tableViewCell = [departuresVC tableView:nil
                                      cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [[tableViewCell.textLabel.text should] equal:@"dest 2"];
        });

        it( @"renders the etd", ^{
            NSArray *departures = @[
            [[UpcomingDeparture alloc] initWithDestinationName:@"dest 1" etd:@(0)],
            [[UpcomingDeparture alloc] initWithDestinationName:@"dest 2" etd:@(1)],
            [[UpcomingDeparture alloc] initWithDestinationName:@"dest 3" etd:@(2)]
            ];
            departuresVC.departures = departures;
            
            UITableViewCell *tableViewCell = [departuresVC tableView:nil
                                               cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [[tableViewCell.detailTextLabel.text should] equal:[departures[1] etdToDisplay]];
        });
    });
});
SPEC_END