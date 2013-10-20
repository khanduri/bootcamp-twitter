//
//  TimelineViewController.h
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/17/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface TimelineViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
