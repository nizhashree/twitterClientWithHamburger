//
//  ComposeTweetViewController.h
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/10/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tweet.h"

@class ComposeTweetViewController;
@protocol ComposeTweetViewControllerDelegate  <NSObject>
-(void) composeTweetViewController:(ComposeTweetViewController *) composeTweetViewController didCreateTweet:(tweet*) singleTweet;

@end

@interface ComposeTweetViewController : UIViewController
- (void) setReplyTweet:(tweet*) replyTweet;
@property (nonatomic, weak) id<ComposeTweetViewControllerDelegate> delegate;
@end
