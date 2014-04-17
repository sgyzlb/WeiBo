//
//  DockItem.m
//  WeiBo
//
//  Created by Aven on 3/23/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#define kImageRatio 0.6

#import "DockItem.h"

@implementation DockItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // 设置文字属性
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

        
        // 设置图片属性
        self.imageView.contentMode = UIViewContentModeCenter;
        self.adjustsImageWhenHighlighted = NO;
        
        // 设置选中时的图片背景
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        
        
        
    }
    return self;
}

#pragma msrk 重写父类方法 覆盖父类在高亮时的行为 只有不调用 super.....方法
-(void)setHighlighted:(BOOL)highlighted
{
    
}

#pragma mark 返回按钮内部ImageView的边框
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * kImageRatio);
}
#pragma mark 返回按钮内部Label的边框
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY  = contentRect.size.height * kImageRatio - 3;
    CGFloat titleHeight = contentRect.size.height - titleY;
    return CGRectMake(0, titleY , contentRect.size.width, titleHeight);
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
