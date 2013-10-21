//
//  Tweet.h
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/20/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (nonatomic, strong) NSString * text;

+ (NSArray *)tweetsFromDataDict:(NSDictionary *) dataObject;
+ (Tweet *)tweetFromObjectDict:(NSDictionary *) tweetObject;

@end
