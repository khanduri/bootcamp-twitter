//
//  TweetDetailViewController.m
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/21/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import "TweetDetailViewController.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tweetText;

@end

@implementation TweetDetailViewController

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
    self.tweetText.text = self.tweet.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
