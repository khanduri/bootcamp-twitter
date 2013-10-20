//
//  TwitterClient.h
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/19/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import "Constants.h"
#import "AFOAuth1Client.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>


@interface TwitterClient : NSObject

+ (TwitterClient *) instance;

- (void)userTimelineWithCount:(int)count
                      success:(void (^)(NSDictionary *data))success
                      failure:(void (^)(NSError *error))failure;

@end