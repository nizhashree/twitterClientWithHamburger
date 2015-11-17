//
//  HamburgerViewController.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/16/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "HamburgerViewController.h"
#import "MenuViewController.h"


@interface HamburgerViewController ()
@property (weak, nonatomic) IBOutlet UIView *MenuView;
@property (weak, nonatomic) IBOutlet UIView *ContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ContentViewLeftMargin;
@property CGFloat OriginalContentViewStartingLoc;

@end

@implementation HamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setMenuViewController];
}

- (void) setMenuViewController:(MenuViewController*) mvc{
    [self.view layoutIfNeeded];
    [self.MenuView addSubview:[[MenuViewController alloc]init].view];
    [self.view layoutIfNeeded];
}
- (IBAction)onPanGestureEvent:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    if (sender.state == UIGestureRecognizerStateBegan){
       self.OriginalContentViewStartingLoc = self.ContentViewLeftMargin.constant;
    }else if (sender.state == UIGestureRecognizerStateChanged){
        self.ContentViewLeftMargin.constant = self.OriginalContentViewStartingLoc + translation.x;
    }else if(sender.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.3 animations:^{
            if(velocity.x > 0){
                self.ContentViewLeftMargin.constant = self.OriginalContentViewStartingLoc + self.view.frame.size.width - 50;
            }else {
                self.ContentViewLeftMargin.constant  = 0;
            }
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
