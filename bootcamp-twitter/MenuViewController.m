//
//  MenuViewController.m
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/18/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (strong, nonatomic) NSArray * menuItems;

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.menuItems = @[@"Home", @"Me", @"Followers"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////
////////    UITableViewDataSource
////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.menuItems.count;
}

////////////////////////////////////////
////////    UITableViewDelegate
////////////////////////////////////////

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCellID" forIndexPath:indexPath];
        
    cell.textLabel.text = self.menuItems[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UINavigationController *navigationController = (UINavigationController *)self.sideMenuViewController.contentViewController;
    
    switch (indexPath.row) {
        case 0:
            navigationController.viewControllers = @[[self.storyboard instantiateViewControllerWithIdentifier:@"timelineViewController"]];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            navigationController.viewControllers = @[[self.storyboard instantiateViewControllerWithIdentifier:@"profileViewController"]];
            [self.sideMenuViewController hideMenuViewController];
            break;
        default:
            break;
    }
}
@end
