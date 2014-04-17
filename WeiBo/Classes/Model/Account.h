//
//  Account.h
//  WeiBo
//
//  Created by Aven on 3/26/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Account : NSObject<NSCoding> // 用于归档 遵守NSCoding协议
// 存储一个微博账号
// accessToken
@property (nonatomic,copy) NSString *accessToken; // accessToken
@property (nonatomic,copy) NSString *uid; // 用户ID
@property (nonatomic,copy) NSString *screenName; // 昵称



@end
