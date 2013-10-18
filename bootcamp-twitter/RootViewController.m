//
//  RootViewController.m
//  bootcamp-twitter
//
//  Created by Prashant Khanduri - Hearsay on 10/18/13.
//  Copyright (c) 2013 KDeal. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)awakeFromNib
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"];
    
}
@end
