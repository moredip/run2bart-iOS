#import "Kiwi.h"

#import "UpcomingDeparturesViewController.h"
#import "Station.h"
#import "BartClient.h"

SPEC_BEGIN(UpcomingDeparturesViewControllerSpec)
describe(@"loading upcoming departures", ^{
    it( @"asks the api client to load the station's departures", ^{
        Station *station = [[Station alloc] initWithName:@"station name" abbr:@"station-abbr"];
        UpcomingDeparturesViewController *departuresVC = [[UpcomingDeparturesViewController alloc] initForStation:station];
        
        id mockBartClient = [KWMock mockForClass:[BartClient class]];
        departuresVC.bartClient = mockBartClient;
        
        [[mockBartClient should] receive:@selector(fetchUpcomingDeparturesForStation:success:failure:)
                               andReturn:nil
                           withArguments:station,any(),any()];
        
        [departuresVC viewWillAppear:YES];
    });
});
SPEC_END