//
//  ProfileViewController.m
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/18/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import "ProfileViewController.h"
#import "TwitterClient.h"

@interface ProfileViewController ()
- (IBAction)showMenu:(id)sender;
- (IBAction)compose:(id)sender;

@end

@implementation ProfileViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenu:(id)sender {
    [self.sideMenuViewController presentMenuViewController];
}

- (IBAction)compose:(id)sender {
    [[TwitterClient instance] composeTweetInViewController: self];
}
@end
