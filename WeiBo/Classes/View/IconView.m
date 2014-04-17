//
//  IconView.h
//  WeiBo
//
//  Created by Aven on 4/6/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "User.h"
#import "IconView.h"
#import <QuartzCore/QuartzCore.h>

@interface IconView()
{
    // 1.头像
    UIImageView *_icon;
    
    // 2.认证图标
    UIImageView *_verified;
    
    // 3.占位图片
    NSString *_placehoder;
}
@end

@implementation IconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加2个子控件
        
        // 1.头像
        _icon = [[UIImageView alloc] init];
        _icon.layer.cornerRadius = 5;
        _icon.layer.masksToBounds = YES;
        [self addSubview:_icon];
        
        // 2.认证图标
        _verified = [[UIImageView alloc] init];
        _verified.bounds = CGRectMake(0, 0, kVerifiedWidth, kVerifiedHeight);
        [self addSubview:_verified];
        
        // 3.默认小图片
        self.iconViewType = IconViewTypeSmall;
        
        // 不能这么写
        //_iconViewType = IconViewTypeSmall;
    }
    return self;
}

- (void)setUser:(User *)user
{
    _user = user;
    
    // 1.头像
    [_icon setImageWithURL:[NSURL URLWithString:user.profileImageUrl] placeholderImage:[UIImage imageNamed:_placehoder] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    
    // 2.认证图标
    if (user.verifiedType == VerifiedTypenNone) {
        _verified.hidden = YES;
    } else {
        _verified.hidden = NO;
        
        switch (user.verifiedType) {
            case VerifiedTypeDaren: // 达人
                _verified.image = [UIImage imageNamed:@"avatar_grassroot.png"];
                break;
            case VerifiedTypePersonal: // 个人
                _verified.image = [UIImage imageNamed:@"avatar_vip.png"];
                break;
            default : // 企业
                _verified.image = [UIImage imageNamed:@"avatar_enterprise_vip.png"];
                break;
        }
    }
}

- (void)setIconViewType:(IconViewType)iconViewType
{
    _iconViewType = iconViewType;
    
    // 确定头像的尺寸
    CGFloat iconWidth = 0;
    CGFloat iconHeight = 0;
    switch (iconViewType) {
        case IconViewTypeBig:
            iconWidth = kIconBigWidth;
            iconHeight = kIconBigHeight;
            _placehoder = @"avatar_default_big.png";
            break;
        case IconViewTypeSmall:
            iconWidth = kIconSmallWidth;
            iconHeight = kIconSmallHeight;
            _placehoder = @"avatar_default_small.png";
            break;
        case IconViewTypeDefault:
            iconWidth = kIconWidth;
            iconHeight = kIconHeight;
            _placehoder = @"avatar_default.png";
            break;
    }
    
    // 设置控件的位置和尺寸
    self.bounds = CGRectMake(0, 0, iconWidth + kVerifiedWidth * 0.5, iconHeight + kVerifiedHeight * 0.5);
    _icon.frame = CGRectMake(0, 0, iconWidth, iconHeight);
    _verified.center = CGPointMake(iconWidth - 2, iconHeight - 2);
}

+ (CGSize)iconViewSizeWithType:(IconViewType)type
{
    CGFloat iconWidth = 0;
    CGFloat iconHeight = 0;
    switch (type) {
        case IconViewTypeBig:
            iconWidth = kIconBigWidth;
            iconHeight = kIconBigHeight;
            break;
        case IconViewTypeSmall:
            iconWidth = kIconSmallWidth;
            iconHeight = kIconSmallHeight;
            break;
        case IconViewTypeDefault:
            iconWidth = kIconWidth;
            iconHeight = kIconHeight;
            break;
    }
    
    // 返回头像的尺寸
    return CGSizeMake(iconWidth + kVerifiedWidth * 0.5, iconHeight + kVerifiedHeight * 0.5);
}

@end