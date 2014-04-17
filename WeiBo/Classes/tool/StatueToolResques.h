//
//  StatueToolResques.h
//  WeiBo
//
//  Created by Aven on 3/29/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import <Foundation/Foundation.h>

// 专门用来加载微博请求的 获取数据 微博等
@interface StatueToolResques : NSObject
// 工具类尽量保证是类方法
+(void)statuesWithSinceID:(NSString *)sinceID
                    maxID:(NSString *)maID
success:(void(^)(NSMutableArray *statues))success fail:(void(^)())fail;



@end







