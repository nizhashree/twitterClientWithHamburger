//
//  tweet.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/9/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "tweet.h"

@implementation tweet

- (id) initWithDictionary:(NSDictionary*) dictionary{
    self = [super init];
    if (self){
        self.text = dictionary[@"text"];
        NSString* createdAtString = dictionary[@"created_at"];
        self.createdAt = [self parseDate:createdAtString];
        self.retweet_count = (int)dictionary[@"retweet_count"];
        self.favourite_count = (int)dictionary[@"favorite_count"];
        if([dictionary objectForKey:@"retweeted_status"]){
            NSLog(@"%@", dictionary);
           self.user = [[User alloc] initWithDictionary:dictionary[@"retweeted_status"][@"user"]];
           self.retweetUser = [[User alloc] initWithDictionary:dictionary[@"user"]];
        }else{
            self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        }
        
    }
    return self;
}


- (NSDate*) parseDate: (NSString*) inputDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM d HH::mm::ss Z  y";
    return [formatter dateFromString:inputDate];
}

+(NSArray*) tweetsWithArray:(NSArray*) dictionaries{
    NSMutableArray* tweets = [[NSMutableArray alloc]init];
    for(NSDictionary* dictionary in dictionaries){
        [tweets addObject:[[tweet alloc]initWithDictionary:dictionary]];
    }
    return tweets;
}
@end
