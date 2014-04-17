//
//  OauthViewController.m
//  WeiBo
//
//  Created by Aven on 3/26/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "OauthViewController.h"
#import "Account.h"
#import "AccountTool.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

@interface OauthViewController ()
@property (nonatomic,strong) UIWebView *webView;

@end

@implementation OauthViewController

-(void)loadView
{
   self.webView= [[UIWebView alloc] init];
    self.view = self.webView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // 发送请求 加载授权页面
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kOauthURL]];
    [self.webView loadRequest:request];
    
    // 设置代理webview
    self.webView.delegate = self;
   
}

#pragma mark webView代理方法
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示指示器 HUD(指示器)
   MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    hud.labelText = @"正在加载中...";
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 隐藏指示器
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
}

#pragma mark webView每次发送请求都会调用这个方法 这个方法很重要
// 药获取返回的AccessToken的URL
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSLog(@"%@",request.URL);
    //  1 获取路径
    NSString *url = request.URL.absoluteString; // 获取url的字符串
  
    
    // 2  获取#所在的位子
    NSRange range = [url rangeOfString:@"access_token"];
    if (range.length != 0) { // ！=0 代表存在
       
      NSString *paramStr =  [url substringFromIndex:range.location]; // range.location找到#所在的位置
        // 3 切割每个参数
        NSArray *params = [paramStr componentsSeparatedByString:@"&"]; // 返回的地址中有多个& 所以分割后用数组接受
       // 4 创建账号
        Account *account = [[Account alloc] init];
        for (NSString *paramStr in params) {
            NSArray *keyValue = [paramStr componentsSeparatedByString:@"="];
            NSString *key = keyValue[0];
            NSString *value = keyValue[1];
            if ([key isEqualToString:kAccessToken]) {
                account.accessToken = value;
//                NSLog(@"account.accessToken = %@",account.accessToken);
            }else if([key isEqualToString:kUid]){
                account.uid = value;
            
            }
            // 账号：643055866@qq.com
            // 密码：itcastios
        }
        // 5 发送请求获取用户昵称
        // ASI
        // AFNetWorking  避免了json解析 AFJSONRequestOperation
        // 初始化请求对象
        //
//        NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",account.accessToken,account.uid];
////            NSLog(@"account.uid  = %@",account.uid);
//        NSURL *url = [NSURL URLWithString:urlStr];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        // 5  赋值当前账号
        [AccountTool shareAccountTool].currentAcount = account;
        
        
        // 6  封装了一个NSRequest的类方法
        NSURLRequest *request = [NSURLRequest requestWithPath:@"users/show.json" params:@{@"uid" :account.uid}];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
//            NSLog(@"%@",JSON);
            // 获取用户的昵称
            account.screenName = [JSON valueForKey:@"screen_name"]; // AFJSONRequestOperation 会自动将获取的Json数据转换成字典提供给我们是使用，参看微博API 获得key为@"screen_name"的值
            
            // 归档
            [[AccountTool shareAccountTool] addAccount:account];
            
            // 到此请求成功 隐藏指示器
            [MBProgressHUD hideHUDForView:webView animated:YES];
            
            // 成功后回到主界面
            MainViewController *main = [[MainViewController alloc] init];
            self.view.window.rootViewController = main;
#warning 测试左右滑动
//            //首页
//            MainViewController *mainMenuController = [[MainViewController alloc] init];
//            LeftViewController *left = [[LeftViewController alloc] init];
//            
//            SWRevealViewController *revealViewController = [[SWRevealViewController alloc] initWithRearViewController:left frontViewController:mainMenuController];
//            
//            //右侧隐藏视图
//            RightViewController *rightViewController = [[RightViewController alloc] init];
//            revealViewController.rightViewController = rightViewController;
//            
//            //浮动层离左边距的宽度
//            revealViewController.rearViewRevealWidth = 230;
//            
//            //是否让浮动层弹回原位
//            //mainRevealController.bounceBackOnOverdraw = NO;
//            [revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
//            
//            self.view.window.rootViewController = revealViewController;

            
//            NSLog(@"%@",JSON);
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//            NSLog(@"失败:%@",JSON);
            // 到此请求失败 以藏指示器
            [MBProgressHUD hideHUDForView:webView animated:YES];
            
        }];
        
        // 5.2 发送请求
        [operation start];
 
        return NO;// 如果返回的请求包含accessToken，则不通过
    }
    
    return YES; // 如果返回的请求不包含accessToken，则通过
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
