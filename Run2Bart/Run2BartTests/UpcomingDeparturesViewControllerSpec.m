#import "Kiwi.h"

#import "UpcomingDeparturesViewController.h"
#import "Station.h"
#import "BartClient.h"
#import "UpcomingDeparture.h"


typedef void (^FetchSuccessBlock)(NSArray *);
typedef void (^FetchFailureBlock)(NSError *);

@interface SpyBartClient : NSObject<BartClient>{
    BOOL _fetchWasCalled;
}

@property(retain) Station *fetchStation;
@property(copy) FetchSuccessBlock fetchSuccessHandler;
@property(copy) FetchFailureBlock fetchErrorHandler;

@end

@implementation SpyBartClient

- (id)init
{
    self = [super init];
    if (self) {
        _fetchWasCalled = NO;
    }
    return self;
}

- (void)fetchUpcomingDeparturesForStation:(Station *)station
                                  success:(FetchSuccessBlock)success
                                  failure:(FetchFailureBlock)failure{
    _fetchWasCalled = YES;
}

- (void)simulateSuccessfulFetchWithDepartures:(NSArray *)departures{
    assert(self.fetchSuccessHandler);
    self.fetchSuccessHandler(departures);
}

- (BOOL)fetchUpcomingDeparturesWasCalled{
    return _fetchWasCalled;
}

@end

SPEC_BEGIN(UpcomingDeparturesViewControllerSpec)
describe( @"UpcomingDeparturesViewController ", ^{
    __block Station *station;
    __block UpcomingDeparturesViewController *departuresVC;
    
    beforeEach(^{
        station = [[Station alloc] initWithName:@"station name" abbr:@"station-abbr"];
        departuresVC = [[UpcomingDeparturesViewController alloc] initForStation:station];
    });
    
    it( @"has the station's name as the title", ^{        
        // Then
        [[departuresVC.title should] equal:station.name];
    });
    
    
    describe(@"the VC's view appearing", ^{
        it( @"asks the api client to load the upcoming departures", ^{
            SpyBartClient *testDoubleBartClient = [[SpyBartClient alloc] init];
            departuresVC.bartClient = testDoubleBartClient;
            
            [departuresVC viewWillAppear:YES];
            
            [[theValue([testDoubleBartClient fetchUpcomingDeparturesWasCalled]) should] beTrue];
        });

        
        it( @"asks the api client to load the upcoming departures", ^{
            id mockBartClient = [KWMock mockForProtocol:@protocol(BartClient)];
            departuresVC.bartClient = mockBartClient;
            
            [[mockBartClient should] receive:@selector(fetchUpcomingDeparturesForStation:success:failure:)
                                   andReturn:nil];

            [departuresVC viewWillAppear:YES];
        });

        it( @"sets the refresh control to indicate departures are being loaded", ^{
            [[theValue(departuresVC.refreshControl.refreshing) should] beFalse];
            [departuresVC viewWillAppear:YES];
            [[theValue(departuresVC.refreshControl.refreshing) should] beTrue];
        });
        
//        it( @"hides the refreshing UI once the departures are loaded", ^{
//            // Given
//            SpyBartClient *spyBartClient = [[SpyBartClient alloc] init];
//            departuresVC.bartClient = spyBartClient;
//            [departuresVC viewWillAppear:YES];
//            
//            // When
//            NSArray *departures = @[];
//            [spyBartClient simulateSuccessfulFetchWithDepartures:departures];
//            
//            // Then
//            [[theValue(departuresVC.refreshControl.refreshing) should] beFalse];
//        });
        
        // it loads departures for the right station
        // describe success:
        //   it ends refreshing
        //   it displays the dea
        // describe failure:
        //   it ends refreshing
        //   it displays an error?
        
    });
    
    describe(@"refresh control", ^{
        it( @"responds to a refresh control pull down by fetching upcoming departures", ^{
            id mockBartClient = [KWMock mockForProtocol:@protocol(BartClient)];
            departuresVC.bartClient = mockBartClient;
            
            [[mockBartClient should] receive:@selector(fetchUpcomingDeparturesForStation:success:failure:)
                                   andReturn:nil];

            [departuresVC.refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
        });
    });
    
    describe(@"rendering departures", ^{
        it( @"renders a table view cell for each departure", ^{
            // Given
            UITableView *ignoredTableView;
            
            NSArray *departures = @[
              [[UpcomingDeparture alloc] initWithDestinationName:@"dest 1" etd:@(0)],
              [[UpcomingDeparture alloc] initWithDestinationName:@"dest 2" etd:@(1)],
              [[UpcomingDeparture alloc] initWithDestinationName:@"dest 3" etd:@(2)]
            ];
            departuresVC.departures = departures;
            
            // When
            NSInteger numSections = [departuresVC numberOfSectionsInTableView:ignoredTableView];
            NSInteger numRows = [departuresVC tableView:ignoredTableView numberOfRowsInSection:0];
            
            // Then
            [[theValue(numSections) should] equal:theValue(1)];
            [[theValue(numRows) should] equal:theValue(3)];
        });
        
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