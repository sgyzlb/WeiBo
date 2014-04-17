//
//  AccountTool.h
//  WeiBo
//
//  Created by Aven on 3/27/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Account.h"
@class Account; // 并不关心方法的实现

@interface AccountTool : NSObject
@property (nonatomic,strong) Account *currentAcount; // readonly不许更改


+(instancetype)shareAccountTool;
// 添加账号和获取账号
-(void)addAccount:(Account *)account;

@end
