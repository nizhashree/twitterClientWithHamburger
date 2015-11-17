//
//  TwitterClient.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/4/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kConsumerKey = @"sUTC7OG37z54NtiCG5awjAtR0";
NSString * const kConsumerSecret = @"TnB6KSk5QpT4TulnrmKKpf1bIONwKtxtjOKlOVMExaN8d9ja7A";
NSString * const kBaseURL = @"https://api.twitter.com";

NSString * const UserDidLogOutNotification = @"UserDidLogOutNotification";

@interface TwitterClient ()
@property (nonatomic, strong) void(^ loginCompletion)(User* user, NSError* error);
@property (nonatomic, strong) void(^ tweetsCompletion)(NSArray* tweets, NSError* error);
@property (nonatomic, strong) void(^ mentionsCompletion)(NSArray* tweets, NSError* error);
@property (nonatomic, strong) void(^ createTweetCompletion)(tweet* tweetObj, NSError* error);
@property (nonatomic, strong) void(^ reTweetCompletion)(tweet* tweetObj, NSError* error);
@property (nonatomic, strong) void(^ favouriteCompletion)(tweet* tweetObj, NSError* error);
@end

@implementation TwitterClient
// Singleton
+ (TwitterClient*)sharedInstance {
    static TwitterClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(instance == nil)
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL] consumerKey:kConsumerKey consumerSecret:kConsumerSecret];
    });
    return instance;
}

- (void) loginWithCompletion:(void(^)(User* user, NSError* error)) completion{
    self.loginCompletion = completion;
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"twitterDemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"Got request token");
        NSURL* authUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authUrl];
    } failure:^(NSError *error) {
        NSLog(@"Failed to get request token");
        self.loginCompletion(nil, error);
    }];
}

- (void) tweetsWithCompletion:(void(^)(NSArray* tweets, NSError* error)) completion{
    self.tweetsCompletion = completion;
        [self GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                //            NSLog(@"Tweets are: %@", responseObject);
                NSArray* tweets = [tweet tweetsWithArray:responseObject];
                self.tweetsCompletion(tweets, nil);
    
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                NSLog(@"%@", error);
                self.tweetsCompletion(nil, error);
            }];
}
- (void) mentionsWithCompletion:(void(^)(NSArray* tweets, NSError* error)) completion{
    self.mentionsCompletion = completion;
    NSMutableDictionary* params = [NSMutableDictionary new];
    [params setObject:_currentUser.screenName forKey:@"screen_name"];
    
    [self GET:@"1.1/statuses/user_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //            NSLog(@"Tweets are: %@", responseObject);
        NSArray* tweets = [tweet tweetsWithArray:responseObject];
        self.mentionsCompletion(tweets, nil);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        self.mentionsCompletion(nil, error);
    }];
}

- (void) openUrl:(NSURL*) url{
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        [self.requestSerializer saveAccessToken:accessToken];
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            //            NSLog(@"Current user: %@", responseObject);
            User * currentUser = [[User alloc] initWithDictionary:responseObject];
            [self setCurrentUser:currentUser];
            self.loginCompletion(currentUser, nil);
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            NSLog(@"%@", error);
            self.loginCompletion(nil, error);
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        NSLog((@"Get access token failed"));
        self.loginCompletion(nil, error);
    }];

}

- (void) createTweetWithCompletion:(NSDictionary*) params:(void(^)(tweet* tweetObj, NSError* error)) completion{
    _createTweetCompletion = completion;
    [self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        tweet * currentTweet = [[tweet alloc] initWithDictionary:responseObject];
        self.createTweetCompletion(currentTweet, nil);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        self.createTweetCompletion(nil, error);
    }];
}

- (void) reTweetWithCompletion:(long long) tweetID:(void(^)(tweet* tweetObj, NSError* error)) completion{
    _reTweetCompletion = completion;
    NSString* postURL = [NSString stringWithFormat:@"1.1/statuses/retweet/%lld.json", tweetID];
    [self POST:postURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        tweet * currentTweet = [[tweet alloc] initWithDictionary:responseObject];
        self.reTweetCompletion(currentTweet, nil);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        self.reTweetCompletion(nil, error);
    }];
}

- (void) favouriteWithCompletion:(long long) tweetID:(void(^)(tweet* tweetObj, NSError* error)) completion{
    _favouriteCompletion = completion;
    NSMutableDictionary* favParams = [[NSMutableDictionary alloc] init];
    [favParams setValue:[NSString stringWithFormat: @"%lld", tweetID] forKey:@"id"];
    [self POST:@"1.1/favorites/create.json" parameters:favParams success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        tweet * currentTweet = [[tweet alloc] initWithDictionary:responseObject];
        self.favouriteCompletion(currentTweet, nil);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        self.favouriteCompletion(nil, error);
    }];
}

- (void) setCurrentUser:(User *)currentUser{
    if(currentUser != nil) {
        NSData* data =  [NSJSONSerialization dataWithJSONObject:currentUser.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"currentUser"];
        
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"currentUser"];
    }
    _currentUser = currentUser;
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (User*) getCurrentUser {
    if(_currentUser == nil){
       NSData* data =  [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];
        if(data != nil){
            NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _currentUser = [[User alloc] initWithDictionary:dictionary];
        }
    }
    return _currentUser;
}

- (void) setCurrentViewingUser:(User *)CurrentViewingUser{
    if(CurrentViewingUser != nil) {
        NSData* data =  [NSJSONSerialization dataWithJSONObject:CurrentViewingUser.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"CurrentViewingUser"];
        
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"CurrentViewingUser"];
    }
    _CurrentViewingUser = CurrentViewingUser;
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (User*) getCurrentViewingUser {
    if(_CurrentViewingUser == nil){
        NSData* data =  [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentViewingUser"];
        if(data != nil){
            NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _CurrentViewingUser = [[User alloc] initWithDictionary:dictionary];
        }
    }
    return _CurrentViewingUser;
}
@end
