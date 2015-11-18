//
//  MenuViewController.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/16/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "MenuViewController.h"
#import "HamburgerViewController.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"
#import "MenuTableViewCell.h"
#import "ProfileViewController.h"
#import "TweetsViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *MenuTableView;
@property (weak, nonatomic) IBOutlet UIImageView *UserProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *ScreenName;
@property(strong, nonatomic) NSArray* menuArray;
@property(strong, nonatomic) HamburgerViewController* hamburgerController;
@property(strong, nonatomic) NSArray* controllers;
@end

@implementation MenuViewController


- (void)viewDidLoad {
    self.MenuTableView.dataSource = self;
    self.MenuTableView.delegate = self;
    self.MenuTableView.scrollEnabled = NO;
    [self initializeControllers];
    [super viewDidLoad];
    self.menuArray = @[@"Profile", @"Tweets", @"Mentions"];
    User* currentUser = [[TwitterClient sharedInstance] getCurrentUser];
    [self.UserProfilePic setImageWithURL: [NSURL URLWithString: currentUser.profileImageURL]];
    self.UserName.text = currentUser.name;
    self.ScreenName.text = [NSString stringWithFormat:@"@%@",currentUser.screenName];
    [self.MenuTableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"MenuTableViewCell"];
     self.MenuTableView.tableFooterView = [UIView new];
    [self.hamburgerController  changeContentView:self.controllers[1]];
    
//    [self setBlueColor];
}

-(void) setBlueColor{
    [self.view setBackgroundColor:[UIColor colorWithRed:0.33 green:0.67 blue:0.93 alpha:1.0]];
    [self.MenuTableView setBackgroundColor:[UIColor colorWithRed:0.33 green:0.67 blue:0.93 alpha:1.0]];
}

- (void) setHamburger:(HamburgerViewController *)hamburgerController{
    self.hamburgerController = hamburgerController;
}
- (void) initializeControllers{
    ProfileViewController* pvc = [[ProfileViewController alloc] init];
    UINavigationController* nc1 =[self setTweetsController];
    UINavigationController* nc2 =[self setTweetsController];
    TweetsViewController* tvc = [nc1 viewControllers][0];
    TweetsViewController* mvc = [nc2 viewControllers][0];
    [tvc setHamburger:self.hamburgerController];
    [mvc setHamburger:self.hamburgerController];

    [tvc changeTweetType:@"tweets"];
    [mvc changeTweetType:@"mentions"];
    [pvc setHamburger:self.hamburgerController];
    self.controllers = @[pvc, nc1, nc2];
}

- (UINavigationController*) setTweetsController{
    TweetsViewController *tvc = [[TweetsViewController alloc] init];
    tvc.edgesForExtendedLayout = UIRectEdgeNone;
    UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:tvc];
    [unc.navigationBar setBarTintColor:[UIColor colorWithRed:0.33 green:0.67 blue:0.93 alpha:1.0]];
    unc.navigationBar.tintColor = [UIColor whiteColor];
    unc.navigationBar.translucent = YES;
    [unc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    return unc;
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
    return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell"];
    cell.menuLabel.text = self.menuArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.hamburgerController  changeContentView:self.controllers[indexPath.row]];
}


@end
