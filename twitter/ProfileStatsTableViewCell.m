//
//  ProfileStatsTableViewCell.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/17/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "ProfileStatsTableViewCell.h"

@implementation ProfileStatsTableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView.layer setBorderColor:[UIColor colorWithRed:0.66 green:0.59 blue:0.59 alpha:1.0].CGColor];
    [self.contentView.layer setBorderWidth:2.0f];
//    self.contentView.layer.cornerRadius = 3;
    self.contentView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
