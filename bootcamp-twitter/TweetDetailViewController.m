//
//  TweetDetailViewController.m
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/21/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "TwitterClient.h"

@interface TweetDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

- (IBAction)replyOnTweet:(id)sender;
- (IBAction)retweetOnTweet:(id)sender;
- (IBAction)favoriteOnTweet:(id)sender;

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

- (IBAction)replyOnTweet:(id)sender {
    [[TwitterClient instance] composeTweetInViewController: self withReplyTo: self.tweet.screenname];
}

- (IBAction)retweetOnTweet:(id)sender {
    
    [[TwitterClient instance] retweetTweet:self.tweet success:^(NSDictionary * data){
        [[[UIAlertView alloc] initWithTitle:@"Retweet" message:@"Retweeted Successfully" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil] show];
    } failure:^(NSError * error){
        [[[UIAlertView alloc] initWithTitle:@"Retweet" message:@"Retweet attempt failed! Please make sure you have connectivity and retry again." delegate:nil cancelButtonTitle:@"Ok!" otherButtonTitles: nil] show];
    }];
    
}

- (IBAction)favoriteOnTweet:(id)sender {
}
@end
