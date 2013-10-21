//
//  Tweet.m
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/20/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

+ (NSArray *)tweetsFromDataDict:(NSDictionary *)dataObject{
    
    NSMutableArray * tweets = [[NSMutableArray alloc] init];
    
    for (id object in dataObject){
        [tweets addObject:[Tweet tweetFromObjectDict:object]];
    }
    
    return [[NSArray alloc] initWithArray:tweets];
}

+ (Tweet *)tweetFromObjectDict:(NSDictionary *)tweetObject {
    Tweet * tweet = [[Tweet alloc] init];
    
    tweet.text = (NSString * )[tweetObject objectForKey:@"text"];
    
    return tweet;
}

@end
