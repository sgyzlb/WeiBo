//
//  AppDelegate.m
//  WeiBo
//
//  Created by Aven on 3/22/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "NewFeatherViewController.h"
#import "OauthViewController.h"
#import "AccountTool.h"

#import "LeftViewController.h"
#import "RightViewController.h"
#import "DDMenuController.h"

@implementation AppDelegate
//- (void)dealloc
//{
//    [_window release];
//    [super dealloc];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
/*
判断是否是第一次使用

 */
    
    
// 去沙盒中取出版本号
    NSString *key = (NSString *)kCFBundleVersionKey;
    NSString *lastVersionCode = [[NSUserDefaults standardUserDefaults] stringForKey:key];
   NSString *currentVersionCode =  [NSBundle mainBundle].infoDictionary[key];
//    NSLog(@"%@",currentVersionCode);
    
    if ([lastVersionCode isEqualToString:currentVersionCode]) {
        
        [self startWeibo:NO];
        
          }else{
        
        // 保存当前版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersionCode forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
        // 新特征界面介绍
        NewFeatherViewController *newFeatherVC =[[NewFeatherViewController alloc] init];
              newFeatherVC.startBlock = ^(BOOL shared){
                  [self startWeibo:shared];
              };
        self.window.rootViewController = newFeatherVC;
  
    }
    
    
    
 
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)startWeibo:(BOOL)shared
{
    
//    NSLog(@"shared = %d",shared);
    // 1.显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    //  2 如果没有账号 跳到授权页
    if ([AccountTool shareAccountTool].currentAcount) {
        MainViewController *main = [[MainViewController alloc] init];
        self.window.rootViewController = main;
    }else{
    OauthViewController *oauthVC = [[OauthViewController alloc] init]; // 只用一次
    self.window.rootViewController = oauthVC;
    }
    
//    // 3 如果有则到主页面
//    MainViewController *mainVC = [[MainViewController alloc] init];
//    self.window.rootViewController = mainVC;
//    [mainVC release];

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
