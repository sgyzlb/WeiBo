//
//  Dock.h
//  WeiBo
//
//  Created by Aven on 3/23/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import <UIKit/UIKit.h>
// 主界面底部的tabbar
@interface Dock : UIView
// 添加选项卡 内容为：图标和文字
-(void)addDockItemWithIcon:(NSString *)icon title:(NSString *)title;

@property (nonatomic,copy) void (^itemClickBlock)(int index);

@property (nonatomic,assign) int selectedIndex;
@end
