//
//  StatueToolResques.m
//  WeiBo
//
//  Created by Aven on 3/29/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "StatueToolResques.h"
#import "AccountTool.h"
#import "Account.h"
#import "Status.h"

@implementation StatueToolResques
+(void)statuesWithSinceID:(NSString *)sinceID maxID:(NSString *)maID success:(void (^)(NSMutableArray *))success fail:(void (^)())fail
{
    // 字符串为空的时候不能直接写nil
    // 错误：不能写成 sinceID==nil?@"" 不然无法加载数据
    /*
//    sinceID = sinceID==nil?@"":sinceID;
//    maID = maID==nil?@"":maID;
     */
    
    // 正确写法 不传时使用默认的@"0"
    sinceID = sinceID==nil?@"0":sinceID;
    maID = maID==nil?@"0":maID;
    
    // 注：各类字符不可以少 错好多次了！！！
    /*
//    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/home_timeline.json?&access_token=%@&since_id=%@&max_id=%@",[AccountTool shareAccountTool].currentAcount.accessToken,sinceID,maID];
    //    NSURL *url = [NSURL URLWithString:urlStr];
     */
    
    // 创建一个请求对象
    NSURLRequest *resquest = [NSURLRequest requestWithPath:@"statuses/home_timeline.json" params:@{
                                                                                          @"since_id": sinceID,
                                                                                          @"max_id":maID}];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:resquest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // 取出所有微博数 "statuses"
        NSArray *arry = [JSON objectForKey:@"statuses"];
        
        // 解析数据位模型 (每个dic 代表一个微博)
        NSMutableArray *statues = [NSMutableArray array];
        for (NSDictionary *dic in arry) {
            Status *statu = [[Status alloc] initWithDic:dic]; // 将每个Statu取出
            [statues addObject:statu]; // 将取出的statu放入数组中
            //            NSLog(@"%@",statu);
        }
     // 3 回调 如果成功 返回数组
        if (success) {
            success(statues);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        if (fail) {
            fail();
        }
       
        
    }];
    [operation start];
  
}


@end
