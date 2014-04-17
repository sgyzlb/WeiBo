//
//  Status.m
//  WeiBo
//
//  Created by Aven on 3/29/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "Status.h"
/*
 
 返回值字段	字段类型	字段说明
 created_at	string	微博创建时间
 id	   int64	微博ID
 mid	int64	微博MID
 idstr	   string  	字符串型的微博ID
 text	string	微博信息内容
 source	string	微博来源
 user	object	微博作者的用户信息字段 详细
 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count	int	转发数
 comments_count	int	评论数
 attitudes_count	int	表态数 (赞)
 pic_urls	object	微博配图地址。多图时返回多图链接。无配图返回“[]”
 
 */
#import "User.h"
@implementation Status

-(id)initWithDic:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.idstr = [dict objectForKey:@"idstr"];
        self.text = [dict objectForKey:@"text"];
        self.source = [dict objectForKey:@"source"];
        
        self.repostsCount = [[dict objectForKey:@"reposts_count"] integerValue];
        self.commentsCount = [[dict objectForKey:@"comments_count"] integerValue];
        self.attitudesCount = [[dict objectForKey:@"attitudes_count"] integerValue];
        
        self.picurls = [dict objectForKey:@"pic_urls"];
        self.createdAt = [dict objectForKey:@"created_at"];
        
        // 不能随意创建对象 建议先判断是否存在
        NSDictionary *retweetedDic = [dict objectForKey:@"retweeted_status"];
        if (retweetedDic) {
               self.retweetedStatus = [[Status alloc] initWithDic:retweetedDic];
        }
        
        // 同retweetedStatus一样User也是一个模型对象
        NSDictionary *userDic = [dict objectForKey:@"user"];
        if (userDic) {
            // 开辟空间
            User *user = [[User alloc] initWithDic:userDic];
            self.user = user; // 赋值
        }
        
     
        
    }
    return self;
}



-(void)setSource:(NSString *)source
{
    _source = source;
//    NSLog(@"%@",source);
    // 解析来源的标签 <a href="http://app.weibo.com/t/feed/3auC5p" rel="nofollow">皮皮时光机</a>
  int rangStart =  [source rangeOfString:@">"].location + 1;
    int rangEnd = [source rangeOfString:@"</a>"].location;
  _source =  [source substringWithRange:NSMakeRange(rangStart, rangEnd - rangStart)];
    _source = [NSString stringWithFormat:@"来自:%@",_source];
}



- (NSString *)createdAt
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSDate *date = [formatter dateFromString:_createdAt];
    
    NSDate *now = [NSDate date];
    
    // 比较微博发送时间和当前时间
    NSTimeInterval delta = [now timeIntervalSinceDate:date];
    
    
    if (delta < 60) { // 1分钟以内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 60分钟以内
        return [NSString stringWithFormat:@"%.f分钟前", delta/60];
    } else if (delta < 60 * 60 * 24) { // 24小时内
        return [NSString stringWithFormat:@"%.f小时前", delta/(60 * 60)];
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:date];
    }
}


@end











