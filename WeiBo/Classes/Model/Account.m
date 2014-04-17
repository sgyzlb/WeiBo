//
//  Account.m
//  WeiBo
//
//  Created by Aven on 3/26/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "Account.h"

@implementation Account
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.accessToken = [aDecoder decodeObjectForKey:kAccessToken];
        self.uid = [aDecoder decodeObjectForKey:kUid];
        self.screenName = [aDecoder decodeObjectForKey:@"screen_name"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.accessToken forKey:kAccessToken];
    [aCoder encodeObject:self.uid forKey:kUid];
    [aCoder encodeObject:self.screenName forKey:@"screen_name"];
}


@end
