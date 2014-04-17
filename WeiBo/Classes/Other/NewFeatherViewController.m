//
//  NewFeatherViewController.m
//  WeiBo
//
//  Created by Aven on 3/22/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#define kCount 4
#import "NewFeatherViewController.h"
#import "MainViewController.h"

@interface NewFeatherViewController ()<UIScrollViewDelegate>
{
    UIButton *_share;
}

//@property (nonatomic,retain) UIScrollView *scrollerView;
@property (nonatomic,retain) UIPageControl *pageController;

@end

@implementation NewFeatherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
// 自定义孔子器
-(void)loadView
{
    [super loadView];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.image = [UIImage fullScreenImageWithName:@"new_feature_background.png"];
    bgView.userInteractionEnabled = YES;
    self.view = bgView;

    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
   UIScrollView *scrollerView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
//    self.scrollerView.userInteractionEnabled = YES;
   scrollerView.showsHorizontalScrollIndicator = NO;
   scrollerView.pagingEnabled = YES;
    scrollerView.contentSize = CGSizeMake(kCount *scrollerView.bounds.size.width, 0);
    scrollerView.delegate = self;
    // 添加图片
    for (int i = 0 ; i<kCount; i++) {
        [self addImageViewAtIndex:i  inView:scrollerView];
    }
      [self.view addSubview:scrollerView];
   // UIPageController
//    CGRect pageFarme = CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40);
    UIPageControl *page = [[UIPageControl alloc]init];
    page.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height  *0.95);
    page.bounds = CGRectMake(0, 0, 100, 0);
    page.numberOfPages = kCount;
    page.userInteractionEnabled = NO;
    page.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point"]];
    page.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point"]];
    self.pageController = page;
    [self.view addSubview:self.pageController];

    
}

-(void)addImageViewAtIndex:(int)index inView:(UIView *)view
{
    CGSize viewSize = view.frame.size;
    
    // 创建imageView
    UIImageView  *imgView = [[UIImageView alloc] init];
    // 在这儿错过 忘了设置宽度了
    imgView.frame = CGRectMake(index*viewSize.width, 0, viewSize.width, viewSize.height);
    // 设置推按
    NSString *name = [NSString stringWithFormat:@"new_feature_%d.png",index + 1];
    imgView.image = [UIImage fullScreenImageWithName:name];
//    NSLog(@"%@",imgView.image);
    
    // 添加视图
    [view addSubview:imgView];
    
    
    // 如果是最后一张 添加按钮 分享、开始
    if (index == kCount - 1) {
        [self addBtnInView:imgView];
    }
}

#pragma mark 添加按钮 分享、开始
-(void)addBtnInView:(UIView *)view
{
    /*
     1 分享按钮
     2 开按钮
     */
    // 开始按钮
    view.userInteractionEnabled = YES;
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:start];
    // 正常图片
    UIImage *startNormal = [UIImage imageNamed:@"new_feature_finish_button"];
    UIImage *startHighted = [UIImage imageNamed:@"new_feature_finish_button_highlighted"];
    [start setBackgroundImage:startNormal forState:UIControlStateNormal];
    [start setBackgroundImage:startHighted forState:UIControlStateHighlighted];
    [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    // 设置变宽
    start.center = CGPointMake(view.bounds.size.width* 0.5, view.bounds.size.height * 0.85);
    start.bounds = (CGRect){CGPointZero,startNormal.size};
//    start.bounds = CGRectMake(0, 0, startNormal.size.width, startNormal.size.height);
    
    // 分享按钮
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:share];
    // 正常图片
    UIImage *sharetNormal = [UIImage imageNamed:@"new_feature_share_false"];
    UIImage *sharetHighted = [UIImage imageNamed:@"new_feature_share_true"];
    [share setBackgroundImage:sharetNormal
                     forState:UIControlStateNormal];
    [share setBackgroundImage:sharetHighted forState:UIControlStateHighlighted];
    share.adjustsImageWhenHighlighted = NO; // 高粱状态下不改变图片颜色
    [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置变宽
    share.center = CGPointMake(view.bounds.size.width* 0.5, view.bounds.size.height * 0.75);
    share.bounds = (CGRect){CGPointZero,sharetNormal.size};
    
    // UIControlStateSelected由代码控制 而UIControlStateHighlighted人为控制
    [share setBackgroundImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    
   
    // 默认情况下为选中状态
    share.selected = YES;
    _share = share;

}

#pragma mark 开始微博按钮
-(void)start
{
    /*
    // 创建mainVC 切换跟视图控制器 并自动销毁原视图
    // 1.显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    self.view.window.rootViewController = mainVC;
//    [UIApplication sharedApplication].keyWindow;
     */
    if (_startBlock) {
        _startBlock(_share.selected);
    }
    
    
}

// 切换按钮状态
-(void)share:(UIButton *)btn
{
    btn.selected = ! btn.isSelected;
    
}

#warning UIPageController的实现
#pragma  mark 滚动代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 实现pageController换位
    self.pageController.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end















