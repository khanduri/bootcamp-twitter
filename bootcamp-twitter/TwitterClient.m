//
//  TwitterClient.m
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/19/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import "TwitterClient.h"
#import "AFNetworking.h"

@interface TwitterClient ()

@property (strong, nonatomic)ACAccountStore * accountStore;

@end

@implementation TwitterClient

////////////////////////////////////////////////////
//////// Using AFNetwoking and AOAuth
////////////////////////////////////////////////////

//+ (TwitterClient * ) instance{
//    static dispatch_once_t singleton_count;
//    static TwitterClient * instance;
//    
//    // The following will only get executed once during the Apps life cycle
//    dispatch_once(&singleton_count, ^{
//        
//        instance = [[TwitterClient alloc] initWithBaseURL:kTWITTER_BASE_URL key:kTWITTER_CONSUMER_KEY secret:kTWITTER_CONSUMER_SECRET];
//    });
//    
//    return instance;
//}
//
//-(id)initWithBaseURL:(NSURL *)url key:(NSString *)key secret:(NSString *) secret{
//    
//    self = [super initWithBaseURL:url key:key secret:secret];
//    if (self != nil){
//        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
//        
//        NSData * data = [[NSUserDefaults standardUserDefaults] dataForKey:kAccessTokenKey];
//        if (data){
//            self.accessToken = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//        }
//    }
//    return self;
//}

////////////////////////////////////////////////////
//////// Using the iOS Social framework
////////////////////////////////////////////////////

+ (TwitterClient * ) instance {
    static dispatch_once_t singleton_count;
    static TwitterClient * instance;

    // The following will only get executed once during the Apps life cycle
    dispatch_once(&singleton_count, ^{
        instance = [[TwitterClient alloc] init];
    });
    return instance;
}

-(id) init{
    self = [super init];
    if (self != nil){
        self.accountStore = [[ACAccountStore alloc] init];
    }
    return self;
}

- (BOOL)userHasAccessToTwitter
{
    return [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
}

- (void)homeTimelineWithCount:(int)count
                      success:(void (^)(NSDictionary *data))success
                      failure:(void (^)(NSError *error))failure{
    NSURL * url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
    NSDictionary * params = @{
                              @"count" : @(count)
                              };
    
    [self makeTwitterRequestAtURL:url withParams:params requestType:SLRequestMethodGET success:success failure:failure];
}

- (void)userTimelineWithCount:(int)count
                      success:(void (^)(NSDictionary * data))success
                      failure:(void (^)(NSError * error))failure
{
    NSURL * url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
    NSDictionary * params = @{
                              @"count" : @(count)
                              };
    
    [self makeTwitterRequestAtURL:url withParams:params requestType:SLRequestMethodGET success:success failure:failure];

}

-(void)retweetTweet:(Tweet * ) tweet
            success:(void (^)(NSDictionary *data))success
            failure:(void (^)(NSError *error))failure{

    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/retweet/%@.json", tweet.tweetId]];
    [self makeTwitterRequestAtURL:url withParams:nil requestType:SLRequestMethodPOST success:success failure:failure];
    
}


-(void) makeTwitterRequestAtURL: (NSURL * ) url
                     withParams:(NSDictionary *) params
                    requestType: (SLRequestMethod) requestType
                        success:(void (^)(NSDictionary * data))success
                        failure:(void (^)(NSError * error))failure{
    
    if ([self userHasAccessToTwitter]) {
        
        ACAccountType *twitterAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier: ACAccountTypeIdentifierTwitter];
        
        [self.accountStore requestAccessToAccountsWithType:twitterAccountType options:NULL completion:^(BOOL granted, NSError *error) {
            if (granted) {
                NSArray *twitterAccounts = [self.accountStore accountsWithAccountType:twitterAccountType];
                ACAccount* userAccount = [twitterAccounts lastObject];
                
                NSDictionary * baseParams = @{
                                              @"screen_name" : userAccount.username,
                                              };
                
                NSMutableDictionary * reqParams = [[NSMutableDictionary alloc] initWithDictionary:params];
                [reqParams addEntriesFromDictionary:baseParams];
                
                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:requestType URL:url parameters:[reqParams mutableCopy]];
                [request setAccount:userAccount];
                
                [request performRequestWithHandler: ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    
                    if (responseData) {
                        if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                            NSError * error;
                            NSDictionary * data = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
                            if (data) {
                                success(data);
                                //NSLog(@"data : %@", data);
                            } else {
                                NSLog(@"JSON Error: %@", [error localizedDescription]);
                                failure(error);
                            }
                        } else {
                            NSLog(@"The response status code is %d", urlResponse.statusCode);
                            failure(error);
                        }
                    } else {
                        NSLog(@"The server did not respond ... Rate limited?");
                        failure(error);
                    }
                }];
            } else {
                // Access was not granted, or an error occurred
                NSLog(@"%@", [error localizedDescription]);
                failure(error);
            }
        }];
    }
}

-(void) composeTweetInViewController: (UIViewController * ) viewController {
    [self composeTweetInViewController:viewController withReplyTo:nil];
}

-(void) composeTweetInViewController: (UIViewController * ) viewController withReplyTo:(NSString *) screenname {
    if ([self userHasAccessToTwitter]) {
        // Initialize Tweet Compose View Controller
        SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [vc setCompletionHandler:^(SLComposeViewControllerResult result) {
            [viewController dismissViewControllerAnimated:YES completion:nil];
        }];
        
        if (screenname != nil){
            [vc setInitialText:[NSString stringWithFormat:@"@%@", screenname]];
        }
        
        // Display Tweet Compose View Controller Modally
        [viewController presentViewController:vc animated:YES completion:nil];
        
    } else {
        // Show Alert View When The Application Cannot Send Tweets
        NSString * message = @"The application cannot send a tweet at the moment. This is because it cannot reach Twitter or you don't have a Twitter account associated with this device.";
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        
        [alertView show];
    }
}


@end
