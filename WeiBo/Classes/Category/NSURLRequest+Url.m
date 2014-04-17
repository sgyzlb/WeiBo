//
//  NSURLRequest+Url.m
//  WeiBo
//
//  Created by Aven on 3/29/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "NSURLRequest+Url.h"
#import "AccountTool.h"
#import "Account.h"

@implementation NSURLRequest (Url)
+(NSURLRequest *)requestWithPath:(NSString *)path params:(NSDictionary *)params
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@%@",kBaseURL,path];
    
    // 拼接参数（遍历字典）
    if (params) {
        // 拼接一个？
        [urlString appendString:@"?"];
        [urlString appendFormat:@"%@=%@",kAccessToken,[AccountTool shareAccountTool].currentAcount.accessToken];
        // 拼接其他参数
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [urlString appendFormat:@"&%@=%@",key,obj];
        }];
    }
    
//    // 注：各类字符不可以少 错好多次了！！！
//    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/home_timeline.json?&access_token=%@&since_id=%@&max_id=%@",[AccountTool shareAccountTool].currentAcount.accessToken,sinceID,maID];
    
    NSURL *url = [NSURL URLWithString:urlString];
   return  [NSURLRequest requestWithURL:url];

}

@end
