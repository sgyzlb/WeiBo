//
//  StatuesCellFrame.h
//  WeiBo
//
//  Created by Aven on 4/2/14.
//  Copyright (c) 2014 GML. All rights reserved.
//



#import <Foundation/Foundation.h>

@class Status;

@interface StatuesCellFrame : NSObject
@property (nonatomic,assign) CGFloat cellWidth;

// cell的总高度
@property (nonatomic,assign) CGFloat cellHeight;
// 要计算的微博数据
@property (nonatomic,strong)  Status *stutes;

/*
 微博本身的子控件的frame
 */

// 1 头像
@property (nonatomic,assign , readonly) CGRect avatar;

// 2 昵称
@property (nonatomic,assign , readonly) CGRect screenName;

// 3 会员皇冠图标
@property (nonatomic,assign , readonly) CGRect mbIcon;

//// 4 时间
//@property (nonatomic,assign , readonly) CGRect time;
//
//// 5 来源
//@property (nonatomic,assign , readonly) CGRect source;

// 6 正文
@property (nonatomic,assign , readonly) CGRect content;

// 7 配图
@property (nonatomic,assign , readonly) CGRect image;



/*
 被转发微博的子控件的frame
 */

// 被转发微博的整体结构
@property (nonatomic,assign , readonly) CGRect retweet;

// 1 昵称
@property (nonatomic,assign , readonly) CGRect retweetScreenName;

// 3 正文
@property (nonatomic,assign , readonly) CGRect retweetContent;

// 4 配图
@property (nonatomic,assign , readonly) CGRect retweetImage;

@end








