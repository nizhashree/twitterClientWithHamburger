//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/9/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeTweetViewController.h"
#import "TwitterClient.h"
@interface TweetDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *retweetedText;
@property (weak, nonatomic) IBOutlet UIButton *retweetedButton;
@property (weak, nonatomic) IBOutlet UIImageView *UserProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *ScreenName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *tweetDesc;
@property (weak, nonatomic) IBOutlet UILabel *CreatedDate;
@property (weak, nonatomic) IBOutlet UILabel *RetweetCount;
@property (weak, nonatomic) IBOutlet UILabel *FavouriteCount;
@property (weak, nonatomic) IBOutlet UIButton *ReplyButton;
@property (weak, nonatomic) IBOutlet UIButton *RetweetButton;
@property (weak, nonatomic) IBOutlet UIButton *FavButton;

@end

@implementation TweetDetailsViewController
- (IBAction)onReply:(id)sender {
    _ReplyButton.userInteractionEnabled = NO;
    ComposeTweetViewController *vc = [[ComposeTweetViewController alloc] init];
    [vc setReplyTweet:_singleTweet];
    vc.delegate = self;
    vc.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)onRetweet:(id)sender {
    _RetweetButton.userInteractionEnabled = NO;
    [[TwitterClient sharedInstance] reTweetWithCompletion:_singleTweet.tweetID :^(tweet *tweetObj, NSError *error) {
        if(error == nil){
            //success
            self.RetweetCount.text = [NSString stringWithFormat:@"%d", tweetObj.retweet_count];
        }else {
            //error
        }
    }];
}
- (IBAction)onLiking:(id)sender {
    _FavButton.userInteractionEnabled = NO;
    [[TwitterClient sharedInstance] favouriteWithCompletion:_singleTweet.tweetID :^(tweet *tweetObj, NSError *error) {
        if(error == nil){
            //success
            self.FavouriteCount.text = [NSString stringWithFormat:@"%d", tweetObj.favourite_count];
        }else {
            //error
        }

    } ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ScreenName.text = self.singleTweet.user.name;
    self.userName.text = [NSString stringWithFormat:@"@%@", _singleTweet.user.screenName];
    self.tweetDesc.text = _singleTweet.text;
    self.RetweetCount.text = [NSString stringWithFormat:@"%d", _singleTweet.retweet_count];
    self.FavouriteCount.text = [NSString stringWithFormat:@"%d", _singleTweet.favourite_count];
    [self.UserProfilePic setImageWithURL:[NSURL URLWithString:_singleTweet.user.profileImageURL]];
    [self setCreatedTimeStamp: _singleTweet.createdAt];
    if(self.singleTweet.retweetUser.name != nil){
        self.retweetedButton.hidden = NO;
        self.retweetedText.hidden = NO;
        self.retweetedText.text = [NSString stringWithFormat:@"%@ retweeted", self.singleTweet.retweetUser.name];
    }else{
        self.retweetedButton.hidden = YES;
        self.retweetedText.hidden = YES;
    }
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

-(void) composeTweetViewController:(ComposeTweetViewController *) composeTweetViewController didCreateTweet:(tweet*) singleTweet{
    [self.navigationController popViewControllerAnimated:YES];
//    [self.tweets insertObject:singleTweet atIndex:0];
//    [self.TweetsTableView reloadData];
}

@end
