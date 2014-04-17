//
//  UIBarButtonItem+creat.m
//  WeiBo
//
//  Created by Aven on 3/23/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "UIBarButtonItem+creat.h"

@implementation UIBarButtonItem (creat)
+(UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon addTarget:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize btnSize = [btn setAllStateBg:icon];
    btn.bounds = (CGRect) {CGPointZero,btnSize};
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 返回自定义的把人buttonItem
    return [[UIBarButtonItem alloc] initWithCustomView:btn];

}
+(UIBarButtonItem *)barButtonItemWithBg:(NSString *)bg title:(NSString *)title size:(CGSize)size addTarget:(id)target action:(SEL)action
{
    // 3  customButton
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 3.1 按钮文字
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    btn.titleLabel.font  = [UIFont systemFontOfSize:15];
    // 3.2 按钮图片
    //    [btn setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_send_background.png"] forState:UIControlStateNormal];
    //        [btn setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_send_background_highlighted.png"] forState:UIControlStateHighlighted];
    
    [btn setAllStateBg:bg];
    
    // 3.3 按钮边框
    btn.bounds = (CGRect){CGPointZero,size};
    // 3.4 监听器
    [btn addTarget:target   action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 3 右边按钮
   return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
