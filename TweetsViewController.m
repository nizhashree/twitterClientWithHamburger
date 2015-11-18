//
//  TweetsViewController.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/9/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "TweetsViewController.h"
#import "TweetDetailsViewController.h"
#import "ComposeTweetViewController.h"
#import "ProfileViewController.h"
#import "LoginViewController.h"
#import "TweetTableViewCell.h"
#import "TwitterClient.h"
#import "tweet.h"
#import "MBProgressHUD.h"

@interface TweetsViewController ()<UITableViewDataSource, UITableViewDelegate, ComposeTweetViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *TweetsTableView;
@property NSMutableArray* tweets;
@property NSString* tweetType;
@property HamburgerViewController* hamburgerViewController;

@end

@implementation TweetsViewController
-(void) setHamburger:(HamburgerViewController*) hamburgerViewController{
    self.hamburgerViewController = hamburgerViewController;
}
- (void)viewDidLoad {
    self.title = @"Home";
    [super viewDidLoad];
    self.TweetsTableView.dataSource = self;
    self.TweetsTableView.delegate = self;
    self.TweetsTableView.estimatedRowHeight = 86;
    self.TweetsTableView.rowHeight = UITableViewAutomaticDimension;
    self.TweetsTableView.hidden = YES;
    [self.TweetsTableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"TweetTableViewCell"];
    [self setNavigationBar];
}

- (void) changeTweetType:(NSString*) tweetType{
    self.tweetType = tweetType;
    if([tweetType  isEqual: @"mentions"]){
       self.title = @"Mentions";
       [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       [[TwitterClient sharedInstance] mentionsWithCompletion:^(NSArray *tweets, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if(error == nil) {
                self.TweetsTableView.hidden = NO;
                for(tweet* singleTweet in tweets){
                    NSLog(@"%@ -- %@", singleTweet.createdAt, singleTweet.text);
                }
                self.tweets = tweets;
                [self.TweetsTableView reloadData];
            }
            else{
                //handle error case
            }
        }];
    }else{
        self.title = @"Tweets";
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[TwitterClient sharedInstance] tweetsWithCompletion:^(NSArray *tweets, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if(error == nil) {
                self.TweetsTableView.hidden = NO;
                for(tweet* singleTweet in tweets){
                    NSLog(@"%@ -- %@", singleTweet.createdAt, singleTweet.text);
                }
                self.tweets = tweets;
                [self.TweetsTableView reloadData];
            }
            else{
                //handle error case
            }
        }];
    }
    
}

-(void) setNavigationBar {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 70, 30);
    [button setTitle:@"New" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(goToComposeTweetController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(10, 0, 70, 30);
    [button2 setTitle:@"Sign Out" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(onSignOut) forControlEvents:UIControlEventTouchUpInside];
    button2.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
}

-(void) onSignOut{
    [[TwitterClient sharedInstance] setCurrentUser:nil];
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogOutNotification object:nil];
//    LoginViewController *tvc = [[LoginViewController alloc] init];
//    [self presentViewController:tvc animated:NO completion:nil];
}

-(void) goToComposeTweetController{
    ComposeTweetViewController *vc = [[ComposeTweetViewController alloc] init];
    vc.delegate = self;
    vc.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController pushViewController:vc animated:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (TweetTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell"];
    [cell setTweet:self.tweets[indexPath.row]];
    return cell;
}

-(void) tweetTableViewCell:(TweetTableViewCell *) tweetTableViewCell profileImageClicked:(BOOL) value{
    if(value){
        ProfileViewController* pvc = [[ProfileViewController alloc] init];
        [self presentViewController:pvc animated:YES completion:nil];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"I got second");
    [self.TweetsTableView deselectRowAtIndexPath:indexPath animated:YES];
    TweetTableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    TweetDetailsViewController *vc = [[TweetDetailsViewController alloc] init];
    vc.edgesForExtendedLayout = UIRectEdgeNone;
    [vc setJson:selectedCell.singleTweet];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void) composeTweetViewController:(ComposeTweetViewController *) composeTweetViewController didCreateTweet:(tweet*) singleTweet{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.tweets insertObject:singleTweet atIndex:0];
    [self.TweetsTableView reloadData];
}

@end
