//
//  AccountTool.m
//  WeiBo
//
//  Created by Aven on 3/27/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#define kFileName   @"accounts.archiver" // 账号名
#define kCurrentAcount  @"currentAccount.archiver"

//#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kFileName]
//
//#define kCurrentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kCurrentAcount]

#import "AccountTool.h"
#import "Account.h"

@interface AccountTool ()
{
    NSMutableArray *_accounts;
}
@end


@implementation AccountTool
+(instancetype)shareAccountTool
{
    static AccountTool *accountool = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (accountool == nil) {
            accountool = [[AccountTool alloc] init];
        }
    });
    
    return accountool;
}
// 归档 第一次归档先读挡 要初始化
-(id)init
{
    if (self = [super init]) {
        // 1 .从文件中读取（解档 读档）
        // 1.1 获取路径
        // 加载账号信息
//        NSArray *doucments = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *accountFilePath = [[doucments objectAtIndex:0] stringByAppendingPathComponent:@"hahah.sqlite"];
//        NSLog(@"%@",accountFilePath);
       NSString *accountFilePath =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kFileName];
        NSLog(@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kFileName]);
        NSString *currentFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kCurrentAcount];
        
      
        // 1.2 从文件中读取I(解档)账号的信息
        _accounts =   [NSKeyedUnarchiver unarchiveObjectWithFile: accountFilePath];
        _currentAcount = [NSKeyedUnarchiver unarchiveObjectWithFile:currentFilePath];
        // 2 如果账号为空号
        if (_accounts == nil) {
            _accounts = [NSMutableArray array];
            
        }
        
    }
    return self;
}
// 新添加一账号
-(void)addAccount:(Account *)account
{
    // 1 存取对象
    [_accounts addObject:account];
    _currentAcount = account;

    // 2  归档 账号
    // 2 .1 所有账号
    NSString *accountsPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:kFileName];
    [NSKeyedArchiver archiveRootObject:_accounts toFile:accountsPath];
    // 2 .2 对当前账号归档 （只读）
    NSString *currentPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0 ] stringByAppendingPathComponent:kCurrentAcount];
    [NSKeyedArchiver archiveRootObject:_currentAcount toFile:currentPath];
    
    // 2.归档
//    [NSKeyedArchiver archiveRootObject:_currentAcount toFile:kCurrentPath];
//    [NSKeyedArchiver archiveRootObject:_accounts toFile:kFilePath];
    
}

@end
