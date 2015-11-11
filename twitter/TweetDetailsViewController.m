//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/9/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface TweetDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *UserProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *ScreenName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *tweetDesc;
@property (weak, nonatomic) IBOutlet UILabel *CreatedDate;
@property (weak, nonatomic) IBOutlet UILabel *RetweetCount;
@property (weak, nonatomic) IBOutlet UILabel *FavouriteCount;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.singleTweet = singleTweet;
//    self.tweetDescription.text = singleTweet.text;
//    self.UserID.text = [NSString stringWithFormat:@"@%@", singleTweet.user.screenName];
//    self.UserName.text = singleTweet.user.name;
//    [self.UserProfileImage setImageWithURL: [NSURL URLWithString: singleTweet.user.profileImageURL]];
//    [self setCreatedTimeStamp: singleTweet.createdAt];
    self.ScreenName.text = self.singleTweet.user.name;
    self.userName.text = [NSString stringWithFormat:@"@%@", _singleTweet.user.screenName];
    self.tweetDesc.text = _singleTweet.text;
    self.RetweetCount.text = [NSString stringWithFormat:@"%d", _singleTweet.retweet_count];
    self.FavouriteCount.text = [NSString stringWithFormat:@"%d", _singleTweet.favourite_count];
    [self.UserProfilePic setImageWithURL:[NSURL URLWithString:_singleTweet.user.profileImageURL]];
    [self setCreatedTimeStamp: _singleTweet.createdAt];
}

- (void) setCreatedTimeStamp:(NSDate*) timestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"M/d/y HH::mm";
     self.CreatedDate.text = [formatter stringFromDate:timestamp];
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

-(void) setJson:(tweet*)singleTweet{
    self.singleTweet = singleTweet;
}

@end
