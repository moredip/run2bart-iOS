//
//  UpcomingDeparturesViewController.m
//  Run2Bart
//
//  Created by Pete Hodgson on 3/28/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import "UpcomingDeparturesViewController.h"
#import "Station.h"
#import "UpcomingDeparture.h"

@interface UpcomingDeparturesViewController ()
@property(nonatomic,retain) Station *station;
@property(nonatomic,retain) NSArray *departures;
@end

@implementation UpcomingDeparturesViewController

- (id)initForStation:(Station *)station
{
    self = [super init];
    if (self) {
        self.station = station;
        self.title = station.name;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [self.station fetchUpcomingDeparturesAndOnSuccess:^(NSArray *departures) {
        self.departures = departures;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        // TODO: handle failure
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( !self.departures )
        return 1;
    else
        return self.departures.count;
    
}

- (UITableViewCell *)loadingTableViewCell{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.text = @"Loading...";
    cell.textLabel.font = [UIFont systemFontOfSize:20.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:30.0];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( !self.departures )
        return [self loadingTableViewCell];
    
    UpcomingDeparture *departure = [self.departures objectAtIndex:indexPath.row];

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if( !cell )
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = departure.destinationName;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Nothing to do
}

@end
