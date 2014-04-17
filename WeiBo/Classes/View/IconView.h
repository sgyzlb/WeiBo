//
//  IconView.h
//  WeiBo
//
//  Created by Aven on 4/6/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

typedef enum {
    IconViewTypeSmall = 0,
    IconViewTypeDefault,
    IconViewTypeBig
} IconViewType;

@interface IconView : UIView

@property (nonatomic, strong) User *user;

@property (nonatomic, assign) IconViewType iconViewType;

// 返回头像的尺寸
+ (CGSize)iconViewSizeWithType:(IconViewType)type;

@end
