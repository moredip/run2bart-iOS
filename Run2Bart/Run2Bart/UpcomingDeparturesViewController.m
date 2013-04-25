//
//  UpcomingDeparturesViewController.m
//  Run2Bart
//
//  Created by Pete Hodgson on 3/28/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import "UpcomingDeparturesViewController.h"
#import "AppDelegate.h"
#import "BartClient.h"
#import "Station.h"
#import "UpcomingDeparture.h"

@interface UpcomingDeparturesViewController ()
@property(nonatomic,retain) Station *station;

- (void) refreshUpcomingDepartures;

@end

@implementation UpcomingDeparturesViewController

- (id)initForStation:(Station *)station
{
    self = [super init];
    if (self) {
        self.station = station;
        self.title = station.name;
        self.bartClient = [AppDelegate sharedInstance].bartClient;
        self.refreshControl = [[UIRefreshControl alloc] init];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating upcoming departures"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [self refreshUpcomingDepartures];
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
    return self.departures.count;
}

- (void) configureTableViewCell:(UITableViewCell *)cell forDeparture:(UpcomingDeparture *)departure
{
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:24.0];
    cell.textLabel.text = departure.destinationName;
    cell.detailTextLabel.text = departure.etdToDisplay;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForDeparture:(UpcomingDeparture *)departure
                                              
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if( !cell )
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    [self configureTableViewCell:cell forDeparture:departure];
    return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UpcomingDeparture *departure = [self.departures objectAtIndex:indexPath.row];
    return [self tableView:tableView cellForDeparture:departure];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Nothing to do
}

#pragma mark - 

- (void) refreshUpcomingDepartures{
    [self.refreshControl beginRefreshing];
    [self.bartClient fetchUpcomingDeparturesForStation:self.station
                                               success:^(NSArray *departures) {
                                                   [self.refreshControl endRefreshing];
                                                   self.departures = departures;
                                                   [self.tableView reloadData];
                                               } failure:^(NSError *error) {
                                                   [self.refreshControl endRefreshing];
                                               }];
}


@end
