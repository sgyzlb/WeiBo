//
//  StatuesOptionBar.h
//  WeiBo
//
//  Created by Aven on 4/13/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

// 操作条 点赞 转发 评论
@class Status;
@interface StatuesOptionBar : UIImageView
@property (nonatomic,strong) Status *status;

@end
