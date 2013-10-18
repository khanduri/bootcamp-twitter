//
//  MenuViewController.h
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/18/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
