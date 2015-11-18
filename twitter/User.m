//
//  User.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/9/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "User.h"

@implementation User
- (id) initWithDictionary:(NSDictionary*) dictionary{
    self = [super init];
    if(self){
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageURL = dictionary[@"profile_image_url"];
        self.tagline = dictionary[@"description"];
        self.followers_count =[NSString stringWithFormat:@"%ld", [dictionary[@"followers_count"] longValue]];
        self.following_count = [NSString stringWithFormat:@"%ld", [dictionary[@"friends_count"] longValue]];
        self.profileBackgroundImageUrl = dictionary[@"profile_background_image_url"];
        self.tweets_count = [NSString stringWithFormat:@"%ld", [dictionary[@"statuses_count"] longValue]];
        self.UserID = dictionary[@"id"];
    }
    return self;
}
@end
