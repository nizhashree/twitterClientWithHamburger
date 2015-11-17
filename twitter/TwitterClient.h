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

extern NSString * const UserDidLogOutNotification;
@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient*)sharedInstance;

@property (nonatomic, strong) User* currentUser;
@property (nonatomic, strong) User* CurrentViewingUser;
- (void) loginWithCompletion:(void(^)(User* user, NSError* error)) completion;
- (void) tweetsWithCompletion:(void(^)(NSArray* tweets, NSError* error)) completion;
- (void) mentionsWithCompletion:(void(^)(NSArray* tweets, NSError* error)) completion;
- (void) createTweetWithCompletion:(NSDictionary*) params:(void(^)(tweet* tweetObj, NSError* error)) completion;
- (void) reTweetWithCompletion:(long long) tweetID:(void(^)(tweet* tweetObj, NSError* error)) completion;
- (void) favouriteWithCompletion:(long long) tweetID:(void(^)(tweet* tweetObj, NSError* error)) completion;
- (void) openUrl:(NSURL*) url;
- (User*) getCurrentUser;
@end
