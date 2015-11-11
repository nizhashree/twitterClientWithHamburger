//
//  TwitterClient.h
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/4/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient*)sharedInstance;

- (void) loginWithCompletion:(void(^)(User* user, NSError* error)) completion;
- (void) tweetsWithCompletion:(void(^)(NSArray* tweets, NSError* error)) completion;
- (void) openUrl:(NSURL*) url;
@end
