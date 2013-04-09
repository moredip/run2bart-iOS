#import "Kiwi.h"

#import "StationsViewController.h"

#import "Station.h"

SPEC_BEGIN(StationsViewControllerSpec)
describe(@"StationsViewController", ^{
    describe( @"table rendering", ^{
        it(@"renders the right number of rows",^{
            NSArray *stations = @[
            [[Station alloc] initWithName:@"station one" abbr:@"s1"],
            [[Station alloc] initWithName:@"station two" abbr:@"s2"],
            [[Station alloc] initWithName:@"station three" abbr:@"s3"]
            ];
            StationsViewController *stationsVC = [[StationsViewController alloc] init];
            stationsVC.stations = stations;
            
            [[theValue([stationsVC numberOfSectionsInTableView:nil]) should] equal:theValue(1)];
            [[theValue([stationsVC tableView:nil numberOfRowsInSection:0]) should] equal:theValue(3)];
        });
        
        it(@"renders table view cells correctly",^{
            NSArray *stations = @[
            [[Station alloc] initWithName:@"station one" abbr:@"s1"],
            [[Station alloc] initWithName:@"station two" abbr:@"s2"],
            [[Station alloc] initWithName:@"station three" abbr:@"s3"]
            ];
            StationsViewController *stationsVC = [[StationsViewController alloc] init];
            stationsVC.stations = stations;
            
            UITableViewCell *secondTableViewCell = [stationsVC tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            
            [[secondTableViewCell.textLabel.text should] equal:@"station two"];
        });
        
    });
});

SPEC_END