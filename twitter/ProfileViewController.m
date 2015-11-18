//
//  ProfileViewController.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/16/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "ProfileViewController.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"
#import "ProfileStatsTableViewCell.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *ScreenName;
@property (weak, nonatomic) IBOutlet UIView *HeaderView;
@property (weak, nonatomic) IBOutlet UITableView *StatsTable;
@property HamburgerViewController* hamburgerViewController;

@end

@implementation ProfileViewController
-(void) setHamburger:(HamburgerViewController*) hamburgerViewController{
    self.hamburgerViewController = hamburgerViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.StatsTable.dataSource = self;
    self.StatsTable.delegate = self;
    User* currentUser = [[TwitterClient sharedInstance] getCurrentUser];
    [_profilePic setImageWithURL:[NSURL URLWithString:currentUser.profileImageURL]];
    _UserName.text = currentUser.name;
    _ScreenName.text = [NSString stringWithFormat:@"@%@",  currentUser.screenName];
    _HeaderView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:currentUser.profileBackgroundImageUrl]]]];
    [self.StatsTable registerNib:[UINib nibWithNibName:@"ProfileStatsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProfileStatsTableViewCell"];
    self.StatsTable.rowHeight = UITableViewAutomaticDimension;
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
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    User* current_user = [[TwitterClient sharedInstance] getCurrentUser];
    ProfileStatsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileStatsTableViewCell"];
    
    cell.tweets_count.text = current_user.tweets_count;
    cell.following_count.text = current_user.following_count;
    cell.followers_count.text = current_user.followers_count;
    return cell;
}


@end
