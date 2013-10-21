//
//  TimelineViewController.m
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/17/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import "TimelineViewController.h"
#import "TwitterClient.h"
#import "Tweet.h"

@interface TimelineViewController ()
- (IBAction)showMenu:(id)sender;
- (IBAction)compose:(id)sender;

@property (strong, nonatomic) NSArray * tweets;

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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[TwitterClient instance] userTimelineWithCount:20 success:^(NSDictionary * data){
        
        self.tweets = [Tweet tweetsFromDataDict:data];
        [self.tableView reloadData];
        
    } failure:^(NSError * error) {
        NSLog(@"Error:  %@", [error localizedDescription]);
    }];

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

////////////////////////////////////////
////////    UITableViewDataSource
////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return self.tweets.count;
}

////////////////////////////////////////
////////    UITableViewDelegate
////////////////////////////////////////

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeLineCellID" forIndexPath:indexPath];
    
    Tweet * currentTweet = (Tweet * ) self.tweets[indexPath.row];
    cell.textLabel.text = currentTweet.text;
    
    return cell;
}

@end
