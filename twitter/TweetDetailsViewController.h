//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/9/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tweet.h"
#import "HamburgerViewController.h"

@interface TweetDetailsViewController : UIViewController
@property (nonatomic, strong) tweet* singleTweet;
-(void) setHamburger:(HamburgerViewController*) hamburgerViewController;
-(void) setJson:(tweet*)tweet;
@end
