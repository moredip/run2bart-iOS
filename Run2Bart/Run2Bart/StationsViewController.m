//
//  StationsViewController.m
//  Run2Bart
//
//  Created by Pete Hodgson on 3/28/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import "StationsViewController.h"
#import "UpcomingDeparturesViewController.h"
#import "Station.h"

@interface StationsViewController ()
@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) NSArray *stationsToDisplay;
@property(nonatomic,strong) UISearchDisplayController *searchController;
@end

@implementation StationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Stations";
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bart-tiles.png"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.alpha = 0.2;
    self.tableView.backgroundView = imageView;
    
    self.stationsToDisplay = self.stations;
    
    [self setupSearch];
}

- (void) setupSearch{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	[self.searchBar setTintColor:BART_BLUE];
	[self.searchBar setPlaceholder:@"enter part of a station name"];
    
    self.tableView.tableHeaderView = self.searchBar;

    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.searchResultsDelegate = self;
    self.searchController.searchResultsDataSource = self;
    self.searchController.delegate = self;
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
    return self.stationsToDisplay.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if( !cell )
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    Station *station = [self.stationsToDisplay objectAtIndex:indexPath.row];
    cell.textLabel.text = station.name;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Station *station = [self.stationsToDisplay objectAtIndex:indexPath.row];
    
    UpcomingDeparturesViewController *departuresVC = [[UpcomingDeparturesViewController alloc] initForStation:station];
    [self.navigationController pushViewController:departuresVC animated:YES];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString];
    return YES;
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText{
    NSPredicate *sPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
	self.stationsToDisplay = [self.stations filteredArrayUsingPredicate:sPredicate];
}

@end
