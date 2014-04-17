//
//  Dock.m
//  WeiBo
//
//  Created by Aven on 3/23/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "Dock.h"
#import "DockItem.h"

@interface Dock ()
{
    DockItem *_currentItem; // 当前选中的item
}

@end

@implementation Dock
// 重写优先级更高
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 设置背景 拿到image 进行平铺
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    }
    return self;
}

-(void)addDockItemWithIcon:(NSString *)icon title:(NSString *)title
{
//    self.userInteractionEnabled = YES;
    // 1创建
    DockItem *item = [DockItem buttonWithType:UIButtonTypeCustom];
    // 5 添加item;
    [self addSubview:item];
    // 2 设置文字标题
    [item setTitle:title forState:UIControlStateNormal];
    item.titleLabel.font = [UIFont systemFontOfSize:12];
    
    // 3 设置图片
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:[icon fileNameAppend:@"_selected"]] forState:UIControlStateSelected];
    
    // 6 添加监听点击
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];//UIControlEventTouchDown不等手势抬起 按钮图片就更改
    
    // 4 调整item的边框
    [self adjustDockItemFrame];
    
    
}
#pragma mark item的点击事件 itemClick:
-(void)itemClick:(DockItem *)item
{
    // 让当前的item取消选中
    _currentItem.selected = NO;
    // 让心的item选中
    item.selected = YES;
    
    // 让新的item变成当前的选中
    _currentItem =item;
    
    // 4 调用block
    if (_itemClickBlock) {
        _itemClickBlock(item.tag);
    }

}
   
#pragma mark 调整item边框
-(void)adjustDockItemFrame
{
    int count = self.subviews.count;
    // 算出item的尺寸
    CGFloat itemHeight = self.frame.size.height;
    CGFloat itemWidth = self.frame.size.width / count;
    for (int i = 0; i< count; i++) {
        // 1取出子控件
        DockItem *item = self.subviews[i];
//        NSLog(@"button item %@",item);
        // 2 算出边框
        item.frame = CGRectMake( i * itemWidth, 0, itemWidth, itemHeight);
        
        // 3 默认第零个选中
        if (i == 0) {
            item.selected = YES;
            _currentItem = item;
        }
        
        // 设置item的tag
        item.tag = i ;
    }
    
}

#pragma mark 重写设置选中索引的方法
-(void)setSelectedIndex:(int)selectedIndex
{
    // 条件郭略
    if (selectedIndex < 0 || selectedIndex >= self.subviews.count) {
        return;
    }
    // 赋值给成员变量
    _selectedIndex = selectedIndex;
    // 对应的item
    DockItem *item = self.subviews[selectedIndex];
    // 相当于点击了item
    [self itemClick:item];
    
//    _currentItem.selected = NO;
//    item.selected = YES;
//    _currentItem = item;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
