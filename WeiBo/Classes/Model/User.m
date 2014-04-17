//
//  User.m
//  WeiBo
//
//  Created by Aven on 3/29/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "User.h"

// 用户对象包含的信息
@implementation User
-(id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.idstr = [dic objectForKey:@"idstr"];
        self.screenName = [dic objectForKey:@"screen_name"];
        self.profileImageUrl = [dic objectForKey:@"profile_image_url"];
        self.verified = [dic[@"verified"] boolValue];
        self.verifiedType = [[dic objectForKey:@"verified_type"] integerValue];
        
        
        self.mbType = [dic[@"mbtype"] intValue];
        self.mbRank = [dic[@"mbrank"] intValue];
    }
    return self;
}

@end
