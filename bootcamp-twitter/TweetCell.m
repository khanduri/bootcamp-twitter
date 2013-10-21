//
//  TweetCell.m
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/20/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import "TweetCell.h"

@interface TweetCell ()


@end

@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(TweetCell * ) initWithTweet:(Tweet * ) tweet {
    
    self = [super init];
    
    if (self != nil){
        self.tweetText.text = tweet.text;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet
{
    self.tweetText.text = tweet.text;
    self.timestampText.text = tweet.timestamp;
    self.usernameText.text = tweet.username;
    self.profileImage.image = tweet.profileImage;
}


@end
