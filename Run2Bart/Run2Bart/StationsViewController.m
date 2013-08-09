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
    return self.stations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if( !cell )
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    Station *station = [self.stations objectAtIndex:indexPath.row];
    cell.textLabel.text = station.name;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Station *station = [self.stations objectAtIndex:indexPath.row];
    
    UpcomingDeparturesViewController *departuresVC = [[UpcomingDeparturesViewController alloc] initForStation:station];
    [self.navigationController pushViewController:departuresVC animated:YES];
}

@end
