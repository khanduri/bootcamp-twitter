//
//  Tweet.h
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/20/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+AFNetworking.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString * tweetId;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * screenname;
@property (nonatomic, strong) NSString * timestamp;
@property (nonatomic, strong) UIImage * profileImage;

+ (NSArray *)tweetsFromDataDict:(NSDictionary *) dataObject;
+ (Tweet *)tweetFromObjectDict:(NSDictionary *) tweetObject;

@end
