//
//  MBProgressHUD+Show.m
//  WeiBo
//
//  Created by Aven on 3/30/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "MBProgressHUD+Show.h"

@implementation MBProgressHUD (Show)
+(void)showErrorWithText:(NSString *)text icon:(NSString *)icon
{
    // 显示加载失败的图片
    MBProgressHUD *hud =   [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    
    // 1s后自动消失
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
    // 隐藏后hud被移除

}
@end
