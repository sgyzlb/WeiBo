//
//  WaterFlowCell.m
//  WeiBo
//
//  Created by GML on 14-4-17.
//  Copyright (c) 2014年 GML. All rights reserved.
//

#import "WaterFlowCell.h"
#define kTextLabelFont  [UIFont systemFontOfSize:10]

@implementation WaterFlowCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self _creatImageView];
        [self _creatDespLabel];
   

    }
    return self;
}
#pragma 添加子控件
-(void)_creatDespLabel
{
    // 添加描述Label
    self.despLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 10, self.bounds.size.width, 10)];
    //    _despLabel.text = @"测试而已啦";
    self.despLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.55];
    self.despLabel.textColor = [UIColor whiteColor];

    self.despLabel.textAlignment = NSTextAlignmentCenter;
    [self insertSubview:self.despLabel aboveSubview:self.imgView];
}

-(void)_creatImageView
{
    // 图片
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    //    NSString *imgName = [NSString stringWithFormat:@"bg%d.jpg",arc4random_uniform(8)];
    //    _imgView.image = [UIImage imageNamed:imgName];
    [self addSubview:self.imgView];

    
}






-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
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
