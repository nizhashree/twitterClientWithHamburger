//
//  ComposeTweetViewController.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/10/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface ComposeTweetViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *UserProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *Username;
@property (weak, nonatomic) IBOutlet UILabel *screenname;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *CountDecrementor;
@property (weak, nonatomic) IBOutlet UILabel *ReplyLabel;
@property (nonatomic)  tweet* replyTweet;

@end

@implementation ComposeTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tweetText becomeFirstResponder];
    User* currentUser = [[TwitterClient sharedInstance] currentUser];
    [self.UserProfileImage setImageWithURL: [NSURL URLWithString: currentUser.profileImageURL]];
    self.Username.text = currentUser.name;
    self.screenname.text = [NSString stringWithFormat:@"@%@", currentUser.screenName];
    self.CountDecrementor.text = @"140";
    [self setTweetNavigationBar];
    
    if(_replyTweet.user.name){
        _ReplyLabel.hidden = NO;
        _ReplyLabel.text = [NSString stringWithFormat:@"In reply to %@", _replyTweet.user.name];
        _tweetText.text =[NSString stringWithFormat:@"@%@", _replyTweet.user.screenName];
        self.CountDecrementor.text = [NSString stringWithFormat:@"%d", 140 - _tweetText.text.length];
    }else{
        _ReplyLabel.hidden = YES;
    }
}

- (void) setReplyTweet:(tweet*) replyTweet{
    _replyTweet = replyTweet;
}

-(void) setTweetNavigationBar {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 70, 30);
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 0.3f;
    button.layer.cornerRadius = 3;
    [button setTitle:@"Tweet" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(createTweet) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void) createTweet{
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setValue:_tweetText.text forKey:@"status"];
    if(_replyTweet.user.name)
        [params setValue: [NSNumber numberWithLongLong:_replyTweet.tweetID ] forKey:@"in_reply_to_status_id"];
    [[TwitterClient sharedInstance] createTweetWithCompletion:params :^(tweet *tweetObj, NSError *error) {
        if(error == nil){
            NSLog(@"%@", tweetObj);
            [self.delegate composeTweetViewController:self didCreateTweet:tweetObj];
        }
        else {
            // handle error
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(range.length == 0){
        int currentLength = textView.text.length + text.length;
        
        if (currentLength > 140)
            return NO;
        else
         self.CountDecrementor.text = [NSString stringWithFormat:@"%d", 140 - currentLength];
    }else{
        self.CountDecrementor.text = [NSString stringWithFormat:@"%d", 140 - textView.text.length + 1];
    }
    return YES;
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
