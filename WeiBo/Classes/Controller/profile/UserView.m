//
//  UserView.m
//  WeiBo
//
//  Created by GML on 14-4-17.
//  Copyright (c) 2014年 GML. All rights reserved.
//

#import "UserView.h"
#define kBoardMargin  10
#define kLabelHeight    20
#define kButtonWidth    70
#define kButtonHeight   70


@implementation UserView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.jpg"]];
//        [self _creatprofitView];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}


#pragma mark 四个按钮的方法实现
// 点击关注好友push到好友详细列表
-(IBAction)clickFriendsBtn:(UIButton *)friends
{
    NSLog(@"%s",__func__);
}

// 点击粉丝数push到粉丝列表
-(IBAction)clickFllowersBtn:(UIButton *)fllowers
{
    NSLog(@"%s",__func__);
}

// 点击关注好友push到好友详细列表
-(IBAction)clickFavouritesBtn:(UIButton *)favourites
{
    NSLog(@"%s",__func__);
}

// 点击微博按钮push到用户发布过的微博
-(IBAction)clickStatuseaBtn:(UIButton *)statuses
{
    NSLog(@"%s",__func__);
}





#pragma mark profitView 布局子视图
-(void)_creatprofitView
{

    // 计算头像的frame
    CGFloat avarterX = kBoardMargin;
    CGFloat avarterY = kBoardMargin;
    CGSize  avarterSize = CGSizeMake(kIconBigWidth, kIconBigHeight);

    _avater = [[UIImageView alloc] initWithFrame:CGRectMake(avarterX, avarterY, kIconBigWidth, kIconBigWidth)];
    NSLog(@"avater.frame.origin.x = %f, avater.frame.origin.y = %f",_avater.frame.origin.x ,_avater.frame.origin.y);
    [self addSubview:_avater];
    
    // 计算screenName的frame
    CGFloat screenNameX = 2 * kBoardMargin + avarterSize.width;
    CGFloat screenNameY = avarterY;
    CGSize screenNameSize = CGSizeMake(self.bounds.size.width - 100, kLabelHeight);
    
    _screenName = [[UILabel alloc] initWithFrame:CGRectMake(screenNameX, screenNameY, screenNameSize.width, screenNameSize.height)];
    _screenName.text = @"名字";
    [self addSubview:_screenName];
    
    // city
    CGFloat cityX = screenNameX;
    CGFloat cityY = screenNameY + kLabelHeight + kBoardMargin;
    CGSize citySize = screenNameSize;
    _city = [[UILabel alloc] initWithFrame:CGRectMake(cityX, cityY, citySize.width, citySize.height)];
    _city.text = @"城市";
    [self addSubview:_city];
    
    
    // 关注
    _friendsCount = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat friendsX = kBoardMargin;
    CGFloat friendsY = 2*kBoardMargin + avarterY + avarterSize.height;
    CGSize friendSize = CGSizeMake(kButtonWidth, kButtonHeight);
    
    _friendsCount.frame = CGRectMake(friendsX, friendsY, friendSize.width, friendSize.height);
    [_friendsCount setTitle:@"关注数" forState:UIControlStateNormal];
#warning button的点击事件都未添加
    [_friendsCount addTarget:self action:@selector(friendsAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_friendsCount];
    
    // 粉丝
    _followersCount = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat followersX = 2 * kBoardMargin + friendSize.width;
    CGFloat followersY = friendsY;
    CGSize followersSize = CGSizeMake(kButtonWidth, kButtonHeight);
    
    _followersCount.frame = CGRectMake(followersX, followersY, followersSize.width, followersSize.height);
    [_followersCount setTitle:@"粉丝数" forState:UIControlStateNormal];
     [_followersCount addTarget:self action:@selector(friendsAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_followersCount];
    
    // 收藏
    
    _favouritesCount = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat favouritesX = 2 * kBoardMargin + friendSize.width + followersSize.width;
    CGFloat favouritesY = friendsY;
    CGSize favouritesSize = CGSizeMake(kButtonWidth, kButtonHeight);
    
    _favouritesCount.frame = CGRectMake(favouritesX, favouritesY, favouritesSize.width, favouritesSize.height);
    [_favouritesCount setTitle:@"收藏数" forState:UIControlStateNormal];
    
     [_followersCount addTarget:self action:@selector(friendsAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_favouritesCount];

    
}

-(void)friendsAction
{
    NSLog(@"%s",__func__);
}


@end
    