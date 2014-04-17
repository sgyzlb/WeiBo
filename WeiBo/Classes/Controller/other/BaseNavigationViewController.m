//
//  BaseNavigationViewController.m
//  WeiBo
//
//  Created by Aven on 4/15/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#define kDefaultScale  0.4
#define kDefaultAlpha  0.7

#import "BaseNavigationViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BaseNavigationViewController ()
{
    UIImageView *_imageView;
    UIView *_subView; // 黑色覆盖
}

@end

@implementation BaseNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	    // 为控制器的View添加手势监听器
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)]];
    
    // 2 显示截图ImageView
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = [UIScreen mainScreen].applicationFrame; // 自动减去状态栏高度
    
    // 3
    _subView = [[UIView alloc] init];
    _subView.frame = _imageView.frame;
    _subView.backgroundColor = [UIColor blackColor];
    
    
}

//
-(void)cutCurrentView
{
    // 截图
    // 渲染---uiivew
    UIView *cutView =  self.view.window.rootViewController.view;
    /**
     *   开启上下文
     */
   // UIGraphicsBeginImageContext(cutView.frame.size);
    UIGraphicsBeginImageContextWithOptions(cutView.frame.size, YES, 0.0);
    // 将UIView 的涂层渲染到上下文中
    [cutView.layer renderInContext:UIGraphicsGetCurrentContext()];
    // 取出UIIamge对象
    _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();

}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    [self cutCurrentView];
    [super pushViewController:viewController animated:YES];
    
}

#pragma mark 拖拽手势
-(void)panGestureAction:(UIPanGestureRecognizer *)pan
{
    // 如果是根控制器 则直接返回
    if (self.topViewController == self.viewControllers[0]) {
        return;
    }
//    if (pan.state == UIGestureRecognizerStateEnded) {
//        
//    }else{
//    
//    }
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            [self beganDrag:pan];
            break;
        case UIGestureRecognizerStateEnded:
            [self endDrag:pan];
            break;
            break;
        default:
              [self dragging:pan];
            break;
    }
    
}


-(void)beganDrag:(UIPanGestureRecognizer *)pan
{
    // 添加ImageView
    [self.view.window insertSubview:_imageView atIndex:0];
    [self.view.window insertSubview:_subView aboveSubview:_imageView];
    
}

-(void)endDrag:(UIPanGestureRecognizer *)pan
{
    // 挪动的距离
    CGFloat tx =  self.view.transform.tx;
    // 取出宽度
    CGFloat width = self.view.frame.size.width;
    if ( tx<= width * 0.5) { // 往左边挪
        [UIView animateWithDuration:0.3 animations:^{
            // 清空transfrom
            self.view.transform = CGAffineTransformIdentity;
            // 让ImageViewe 恢复默认的scale
            _imageView.transform = CGAffineTransformMakeScale(kDefaultScale, kDefaultScale);
            // 让subView 恢复默认的alpha
            _subView.alpha = kDefaultAlpha;
        } completion:^(BOOL finished) {
            // 移除view
            [_imageView removeFromSuperview];
            [_subView removeFromSuperview];
        }];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{ // 往右边挪
            // 清空transfrom
            self.view.transform = CGAffineTransformMakeTranslation(width, 0);
            // 让ImageViewe 恢复默认的scale
            _imageView.transform = CGAffineTransformMakeScale(1, 1);
            // 让subView 恢复默认的alpha
            _subView.alpha = 0;
        } completion:^(BOOL finished) {
            // 清空transform
             self.view.transform = CGAffineTransformIdentity;
            
            // 移除view
            [_imageView removeFromSuperview];
            [_subView removeFromSuperview];
            
            // 移除栈顶
            [self popToRootViewControllerAnimated:NO];
            
        }];
    
    }
}

-(void)dragging:(UIPanGestureRecognizer *)pan
{
    // 挪动整个导航View
        CGFloat x =  [pan translationInView:self.view].x;
    if (x < 0) {
        x = 0;
    }
        self.view.transform = CGAffineTransformMakeTranslation(x, 0);
  // imageView 缩放
 double xScale =   x / self.view.frame.size.width; // 拖动的距离比例
   double scale = kDefaultScale +( xScale / 0.5 ) *(1 - kDefaultScale);
    if (scale > 1) { // 控制截图大小为1
        scale = 1;
    }
    _imageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    // subVIew的透明度
    double alpha  = kDefaultAlpha - (x / 0.5) *kDefaultAlpha;
    _subView.alpha = alpha;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
