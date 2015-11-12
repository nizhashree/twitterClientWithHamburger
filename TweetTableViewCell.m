//
//  TweetTableViewCell.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/9/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setTweet:(tweet*) singleTweet{
    self.singleTweet = singleTweet;
    self.tweetDescription.text = singleTweet.text;
//    self.UserID.text = [NSString stringWithFormat:@"@%@", singleTweet.user.screenName];
    self.UserName.text = [NSString stringWithFormat:@"%@  @%@", singleTweet.user.name, singleTweet.user.screenName];
    [self.UserProfileImage setImageWithURL: [NSURL URLWithString: singleTweet.user.profileImageURL]];
    [self setCreatedTimeStamp: singleTweet.createdAt];
    if(self.singleTweet.retweetUser.name != nil){
        self.retweetedButton.hidden = NO;
        self.retweetUserName.hidden = NO;
        self.retweetUserName.text = [NSString stringWithFormat:@"%@ retweeted", self.singleTweet.retweetUser.name];
    }else{
        self.retweetedButton.hidden = YES;
        self.retweetUserName.hidden = YES;
        self.retweetUserName.text = @"";
    }
}

- (void) setCreatedTimeStamp:(NSDate*) timestamp{
    NSInteger timeDiff = (NSInteger)[[NSDate date] timeIntervalSinceDate: timestamp];
    if(timeDiff > 86400){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"m/d/y";
        self.CreatedDate.text = [formatter stringFromDate:timestamp];
    }else{
        int hours = timeDiff /3600;
        if(hours > 0)
            self.CreatedDate.text = [NSString stringWithFormat:@"%dh", hours];
        else
            self.CreatedDate.text = [NSString stringWithFormat:@"%dm", timeDiff/60];
    }
}
@end
