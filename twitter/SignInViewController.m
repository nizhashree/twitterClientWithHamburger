//
//  ViewController.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/4/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "SignInViewController.h"
#import "TweetsViewController.h"
#import "TwitterClient.h"

@interface SignInViewController ()
- (IBAction)onLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *successLogin;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User* currentUser = [[TwitterClient sharedInstance] getCurrentUser];
    if(currentUser){
        NSLog(@"%@", currentUser.name);
        self.signInButton.hidden = YES;
        self.successLogin.hidden = NO;
        [self performSelector:@selector(openTweetsViewController) withObject:nil afterDelay:0.0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *currentUser, NSError *error) {
        if(currentUser != nil){
            NSLog(@"%@", currentUser.name);
            [self openTweetsViewController];
        }
        else {
            // print error
        }
    }];
}

- (void) openTweetsViewController{
    TweetsViewController *tvc = [[TweetsViewController alloc] init];
    tvc.edgesForExtendedLayout = UIRectEdgeNone;
    UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:tvc];
    [unc.navigationBar setBarTintColor:[UIColor colorWithRed:0.33 green:0.67 blue:0.93 alpha:1.0]];
    unc.navigationBar.tintColor = [UIColor whiteColor];
    unc.navigationBar.translucent = YES;
    [unc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self presentViewController:unc animated:NO completion:nil];
}
@end
