//
//  User.h
//  WeiBo
//
//  Created by Aven on 3/29/14.
//  Copyright (c) 2014 GML. All rights reserved.
//



typedef enum {
    MBTypeNone = 0,
    MBTypeNomal, // 普通
    MBTypeYear  // 年费
}MBType;

typedef enum {
    VerifiedTypenNone = -1,
    VerifiedTypePersonal = 0,
    VerifiedTypeOrgEnterprice = 2, // 企业官方：
    VerifiedTypeOrgMedia = 3, // 媒体官方
    VerifiedTypeOrgWebsite = 5, // 网站官方
    VerifiedTypeDaren = 220  // 微博达人
}VerifiedType;


#import <Foundation/Foundation.h>

@interface User : NSObject
/*
 
 返回值字段	字段类型	字段说明

 idstr	 string	字符串型的用户UID
 screen_name	string	用户昵称
 name	string	友好显示名称
 province	int	用户所在省级ID
 city	int	用户所在城市ID
 location	string	用户所在地
 description	string	用户个人描述
 url	string	用户博客地址
 profile_image_url	string	用户头像地址（中图），50×50像素
 profile_url	string	用户的微博统一URL地址
 domain	string	用户的个性化域名
 weihao	string	用户的微号
 gender	string	性别，m：男、f：女、n：未知
 followers_count	int	粉丝数
 friends_count	int	关注数
 statuses_count	int	微博数
 favourites_count	int	收藏数
 created_at	string	用户创建（注册）时间

 verified	boolean	是否是微博认证用户，即加V用户，true：是，false：否
 verified_type	int	暂未支持

 status	object	用户的最近一条微博信息字段 详细
 avatar_large	string	用户头像地址（大图），180×180像素
 avatar_hd	string	用户头像地址（高清），高清头像原图

 
 */


@property (nonatomic,copy) NSString * idstr; // 用户ID
@property (nonatomic,copy) NSString * screenName; // 昵 称
@property (nonatomic,copy) NSString * profileImageUrl ;// 头像图片地址
@property (nonatomic,assign) BOOL  verified; // 是否认证
@property (nonatomic,assign) VerifiedType verifiedType; // 认证的类型

@property (nonatomic,assign) MBType mbType; // 会员类型
@property (nonatomic,assign)  int mbRank; // 会员等级


-(id)initWithDic:(NSDictionary *)dic;

@end









