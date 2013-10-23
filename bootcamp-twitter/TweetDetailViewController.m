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
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *screenname;

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
    [self.tweetText sizeToFit];
    
    self.profileImage.image = self.tweet.profileImage;
    self.screenname.text = self.tweet.screenname;
    self.username.text = self.tweet.username;

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
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Retweet" message:@"Retweeted Successfully" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
        
        [self performSelectorOnMainThread:@selector(showAlert:) withObject:alert waitUntilDone:NO];
        
    } failure:^(NSError * error){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Retweet" message:@"Retweet attempt failed! Please make sure you have connectivity and retry again." delegate:nil cancelButtonTitle:@"Ok!" otherButtonTitles: nil];
        
        [self performSelectorOnMainThread:@selector(showAlert:) withObject:alert waitUntilDone:NO];
    }];
}

-(void)showAlert: (UIAlertView * ) alert{
    [alert show];
}

- (IBAction)favoriteOnTweet:(id)sender {
    [[TwitterClient instance] favoriteTweet:self.tweet success:^(NSDictionary * data){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Favorite" message:@"Favorited Successfully" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
        
        [self performSelectorOnMainThread:@selector(showAlert:) withObject:alert waitUntilDone:NO];
    } failure:^(NSError * error){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Favorite" message:@"Favorite attempt failed! Please make sure you have connectivity and retry again." delegate:nil cancelButtonTitle:@"Ok!" otherButtonTitles: nil];
        
        [self performSelectorOnMainThread:@selector(showAlert:) withObject:alert waitUntilDone:NO];
    }];
}

@end
