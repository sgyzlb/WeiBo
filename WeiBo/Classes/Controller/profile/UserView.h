//
//  UserView.h
//  WeiBo
//
//  Created by GML on 14-4-17.
//  Copyright (c) 2014年 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserView : UIView
@property (nonatomic,strong) IBOutlet UIImageView *avater; // 头像
@property (nonatomic,strong) IBOutlet UILabel *screenName; // 用户名
@property (nonatomic,strong) IBOutlet UILabel *url; // 博客地址
@property (nonatomic,strong) IBOutlet UILabel *city; // 所在城市
@property (nonatomic,strong) IBOutlet UILabel *description; // 用户简介


@property (nonatomic,strong) IBOutlet UIButton *friendsCount; // 关注数
@property (nonatomic,strong) IBOutlet UIButton *followersCount; // 粉丝数
@property (nonatomic,strong) IBOutlet UIButton *favouritesCount; // 收藏数


@property (nonatomic,strong) IBOutlet UIButton *statuses; // 微博数


// 点击关注好友push到好友详细列表
-(IBAction)clickFriendsBtn:(UIButton *)friends;

// 点击粉丝数push到粉丝列表
-(IBAction)clickFllowersBtn:(UIButton *)fllowers;

// 点击关注好友push到好友详细列表
-(IBAction)clickFavouritesBtn:(UIButton *)favourites;

// 点击微博按钮push到用户发布过的微博
-(IBAction)clickStatuseaBtn:(UIButton *)statuses;



@end
