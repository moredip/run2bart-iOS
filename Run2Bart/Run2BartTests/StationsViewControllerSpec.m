#import "Kiwi.h"

#import "StationsViewController.h"

#import "Station.h"

SPEC_BEGIN(StationsViewControllerSpec)
describe(@"StationsViewController", ^{
    describe( @"table rendering", ^{
        const CLLocationCoordinate2D genericCoords = {0.0,0.0};
        it(@"renders the right number of rows",^{
            NSArray *stations = @[
            [[Station alloc] initWithName:@"station one" abbr:@"s1" coords:genericCoords],
            [[Station alloc] initWithName:@"station two" abbr:@"s2" coords:genericCoords],
            [[Station alloc] initWithName:@"station three" abbr:@"s3" coords:genericCoords]
            ];
            StationsViewController *stationsVC = [[StationsViewController alloc] init];
            stationsVC.stations = stations;
            
            [[theValue([stationsVC numberOfSectionsInTableView:nil]) should] equal:theValue(1)];
            [[theValue([stationsVC tableView:nil numberOfRowsInSection:0]) should] equal:theValue(3)];
        });
        
        it(@"renders table view cells correctly, in alphabetic order",^{
            NSArray *stations = @[
            [[Station alloc] initWithName:@"station zeta" abbr:@"blah" coords:genericCoords],
            [[Station alloc] initWithName:@"station alpha" abbr:@"blah" coords:genericCoords],
            [[Station alloc] initWithName:@"station beta" abbr:@"blah" coords:genericCoords]
            ];
            StationsViewController *stationsVC = [[StationsViewController alloc] init];
            stationsVC.stations = stations;

            UITableViewCell *firstTableViewCell = [stationsVC tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            UITableViewCell *secondTableViewCell = [stationsVC tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            UITableViewCell *thirdTableViewCell = [stationsVC tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            
            [[firstTableViewCell.textLabel.text should] equal:@"station alpha"];
            [[secondTableViewCell.textLabel.text should] equal:@"station beta"];
            [[thirdTableViewCell.textLabel.text should] equal:@"station zeta"];
        });
    });
    
    // it handles tapping on a station correctly
});

SPEC_END