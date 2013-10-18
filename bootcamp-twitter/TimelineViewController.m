//
//  TimelineViewController.m
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/17/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import "TimelineViewController.h"

@interface TimelineViewController ()
- (IBAction)showMenu:(id)sender;

@end

@implementation TimelineViewController

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

@end
