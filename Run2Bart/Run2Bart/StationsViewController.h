//
//  StationsViewController.h
//  Run2Bart
//
//  Created by Pete Hodgson on 3/28/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StationsViewController : UITableViewController<UISearchDisplayDelegate>
@property(nonatomic,retain) NSArray *stations;
@end
