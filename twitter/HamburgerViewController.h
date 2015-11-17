//
//  HamburgerViewController.h
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/16/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"


@interface HamburgerViewController : UIViewController
- (void) setMenuViewController:(MenuViewController*) mvc;
- (void) changeContentView:(UIViewController*) uvc;
@end
