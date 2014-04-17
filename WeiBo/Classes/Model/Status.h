//
//  Status.h
//  WeiBo
//
//  Created by Aven on 3/29/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 
 返回值字段	字段类型	字段说明
 created_at	string	微博创建时间
 id	   int64	微博ID
 mid	int64	微博MID
 idstr	   string  	字符串型的微博ID
 text	string	微博信息内容
 source	  string	微博来源
 user	object	微博作者的用户信息字段 详细
 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count 	int	转发数
 comments_count	int	评论数
 attitudes_count	int	表态数 (赞)
 pic_urls	object	微博配图地址。多图时返回多图链接。无配图返回“[]”
 
 */

@class User; // 引入user类

@interface Status : NSObject

@property (nonatomic,copy) NSString *text; // 微博内容
@property (nonatomic,copy) NSString *idstr; // 微博id
@property (nonatomic,copy) NSString * source; // 来源
@property (nonatomic ,assign) int repostsCount ; // 转发数
@property (nonatomic,assign) int  commentsCount; // 品论
@property ( nonatomic,assign) int attitudesCount; // 赞
@property (nonatomic,strong)   NSArray * picurls; // 图片资源
@property (nonatomic, copy) NSString *createdAt; // 创建时间
@property (nonatomic,strong) Status *retweetedStatus; // 被转发的微博也是微博 拥有以上属性
@property (nonatomic,strong) User *user; // 转发来的微博的博主


-(id)initWithDic:(NSDictionary *)dict;

@end







