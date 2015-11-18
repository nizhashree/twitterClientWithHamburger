//
//  TweetsViewController.h
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/9/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HamburgerViewController.h"

@interface TweetsViewController : UIViewController
- (void) changeTweetType:(NSString*) tweetType;
-(void) setHamburger:(HamburgerViewController*) hamburgerViewController;
@end
