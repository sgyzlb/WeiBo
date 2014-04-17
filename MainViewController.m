//
//  MainViewController.m
//  WeiBo
//
//  Created by Aven on 3/22/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#define kDochHeight 44
#import "MainViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "Dock.h"
#import "BaseNavigationViewController.h"
#import "AppDelegate.h"


@interface MainViewController ()
{
    UINavigationController *_selectedViewController;
    Dock *_dock;
}

@end
/*
 userInterfaceEnabled = NO;
 hidden = YES;
 alpha <= 0.01
 clearCloro
 无法响应用户事件
 */

@implementation MainViewController

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
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    //添加页面滑动事件（展开隐藏菜单）
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    SWRevealViewController *revealController = (SWRevealViewController *)delegate.window.rootViewController;
//    [self.view addGestureRecognizer:revealController.panGestureRecognizer];

    
    
//    // 1.显示状态栏
//    [UIApplication sharedApplication].statusBarHidden = NO;
    
    // 1 显示Dock
    [self addDock];
    
    // 2  创建所有子控件
    [self creatChildViewControllers];
    
    // 3 默认选中第0个控制器
    [self selecteControllerAtIndex:0];
    
    // 4 设置导航栏主题
    [self setNavigationTheme];
}
#pragma mark 设置导航栏主题
-(void)setNavigationTheme
{
    // 1 导航栏
    // 操作整个应用中的所有导航栏
    UINavigationBar *navBar = [UINavigationBar appearance];
//    [navBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background"]]];
    // 1.2 设置导航栏背景
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background_os7"] forBarMetrics:UIBarMetricsDefault];
    
    // 1.3 设置状态栏背景 状态栏的信息都在UIApplication里
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    // 1.4 设置导航栏文字
//    navBar setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor darkGrayColor]}; // iso7摒弃了TitleTextAttributes
    // 2  设置导航栏上面的Item
       UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_highlighted"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable.png"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
//    barItem.enabled =
//    // item的文字属性
//    barItem setTitleTextAttributes:<#(NSDictionary *)#> forState:UIControlStateNormal
    barItem.tintColor = [UIColor blackColor];
    
    
}

#pragma mark 创建所有子控件
-(void)creatChildViewControllers
{
    HomeViewController *home = [[HomeViewController alloc] init];
//    home.title = @"首页";
    home.view.backgroundColor = kGlobalBg;
    [self addChildViewController:home];

    MessageViewController *message = [[MessageViewController alloc] init];
    message.view.backgroundColor = kGlobalBg;
    [self addChildViewController:message];

    
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    profile.view.backgroundColor = kGlobalBg;

    [self addChildViewController:profile];
 
    
    
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    discover.view.backgroundColor = kGlobalBg;
 
    [self addChildViewController:discover];

    
    MoreViewController *more = [[MoreViewController alloc] initWithStyle:UITableViewStyleGrouped];
    more.view.backgroundColor = kGlobalBg;

    [self addChildViewController:more];

    
//    NSLog(@"uu%d",self.childViewControllers.count);
    
    
}
#pragma mark 添加具有导航功能的子控制器 重写父类的方法
-(void)addChildViewController:(UIViewController *)childController
{
    // 为了需要一个导航条
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:childController];
    nav.delegate  = self;
    
    [super addChildViewController:nav];

    
}

#pragma mark UINavigationController的代理方法
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 设置根控制器
    UIViewController *root = [navigationController.viewControllers objectAtIndex:0];
    
    // 如果出现的视图不是rootViewController则显示back
    if (viewController != root) {
         // 当导航控制器显示子控制器时
        // 左边的返回按钮
    viewController.navigationItem.leftBarButtonItem =   [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_back.png" addTarget:self action:@selector(back )];
        
        // 右边的更多按钮
        viewController.navigationItem.rightBarButtonItem = [ UIBarButtonItem barButtonItemWithIcon:@"theater_favoriteon1.png" addTarget:self action:@selector(home)];
        // 更改导航控制器的frame
        navigationController.view.frame = self.view.bounds;
        
        // 让Dock从mainviewcontroller上移除
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        dockFrame.size.height -= 44;
        _dock.frame = dockFrame;
        
        if ([root.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *s = (UIScrollView *)root.view;
            dockFrame.origin.y = s.contentOffset.y + root.view.frame.size.height - kDochHeight;
        }else{
            dockFrame.origin.y -= kDochHeight;
        }
        
        
        // 添加dock到导航控制器的界面
        [root.view addSubview:_dock];
    }
   }

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 设置根控制器
    UIViewController *root = [navigationController.viewControllers objectAtIndex:0];
    if (viewController == root) {
            navigationController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            // 让Dock从mainviewcontroller上移除
            [_dock removeFromSuperview];
            
            _dock.frame = CGRectMake(0, self.view.frame.size.height - kDochHeight, self.view.bounds.size.width,kDochHeight);
            [self.view addSubview:_dock];

    }
 
}

#pragma mark home 返回主页
-(void)home
{
    [_selectedViewController popToRootViewControllerAnimated:YES];
}

#pragma mark back 返回
-(void)back
{
    [_selectedViewController popViewControllerAnimated:YES];
}


#pragma mark 添加Dock
-(void)addDock
{
    // 2. 添加dock
    Dock *dock = [[Dock alloc] init];
    dock.frame = CGRectMake(0, self.view.frame.size.height - kDochHeight, self.view.bounds.size.width, kDochHeight);
    [self.view addSubview:dock];
    
    // 3 添加Dock里面的item
    [dock addDockItemWithIcon:@"tabbar_home.png" title:@"主页"];
    [dock addDockItemWithIcon:@"tabbar_message_center.png" title:@"消息"];
    [dock addDockItemWithIcon:@"tabbar_profile.png" title:@"我"];
    [dock addDockItemWithIcon:@"tabbar_discover.png" title:@"广场"];
    [dock addDockItemWithIcon:@"tabbar_more.png" title:@"更多"];
    
    //4 监听Dock内部item的点击
    dock.itemClickBlock = ^(int index){
        // ---------传入索引 选中相应控制器-------------
        [self selecteControllerAtIndex:index];
    };

    
    _dock = dock;

}

#pragma mark 选中index位置对应的子控制器
-(void)selecteControllerAtIndex:(int)index
{
    // ---------传入索引 选中相应控制器-------------
    NSLog(@"选中了第%d",index);
    
    // 创建新控制器
    UINavigationController *new = [self.childViewControllers objectAtIndex:index];
    
    if (new == _selectedViewController) {
        return ;
    }
    // 移除当前控制器
    [_selectedViewController.view removeFromSuperview];
    
    
    new.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - kDochHeight);
    [self.view addSubview:new.view];
    
    // 新控制器成为选中控制器
    _selectedViewController = new;
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
