//
//  User.h
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/9/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* screenName;
@property (nonatomic, strong) NSString* profileImageURL;
@property (nonatomic, strong) NSString* profileBackgroundImageUrl;
@property (nonatomic, strong) NSString* followers_count;
@property (nonatomic, strong) NSString* following_count;
@property (nonatomic, strong) NSString* tweets_count;
@property (nonatomic, strong) NSString* tagline;
@property (nonatomic, strong) NSString* UserID;
@property (nonatomic, strong) NSDictionary* dictionary;

- (id) initWithDictionary:(NSDictionary*) dictionary;
@end
