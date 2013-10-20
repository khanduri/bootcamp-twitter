//
//  TimelineViewController.m
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/17/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import "TimelineViewController.h"
#import "TwitterClient.h"

@interface TimelineViewController ()
- (IBAction)showMenu:(id)sender;

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
    
    // TODO : remove this
    self.tweets = @[@"Tweet 1", @"Tweet 2"];
    
    [[TwitterClient instance] userTimelineWithCount:20 success:^(NSDictionary * data){
        NSLog(@"YEEEEeeeewesfskjdfahkjsdhfsdhaf: %@\n", data);
    } failure:^(NSError * error) {
        NSLog(@"uududshfhjafdjfksdafds Error: %@", [error localizedDescription]);
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
    
    cell.textLabel.text = self.tweets[indexPath.row];
    
    return cell;
}

@end
