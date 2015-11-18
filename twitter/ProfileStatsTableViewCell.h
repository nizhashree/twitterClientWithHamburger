//
//  ProfileStatsTableViewCell.h
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/17/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileStatsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tweets_count;
@property (weak, nonatomic) IBOutlet UILabel *followers_count;
@property (weak, nonatomic) IBOutlet UILabel *following_count;

@end
