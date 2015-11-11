//
//  tweet.h
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/9/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface tweet : NSObject
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSDate* createdAt;
@property (nonatomic, strong) User* user;
@property int retweet_count;
@property int favourite_count;
@property (nonatomic, strong) User* retweetUser;

- (id) initWithDictionary:(NSDictionary*) dictionary;

+(NSArray*) tweetsWithArray:(NSArray*) dictionaries;

@end
