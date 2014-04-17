//
//  WaterFlowCellView.m
//  WeiBo
//
//  Created by Aven on 4/17/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "WaterFlowCellView.h"

@implementation WaterFlowCellView

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super init];
    if (self) {
        // 使用和属性记录可重用标识符
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}

// 写imageView的getter方法
-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
    }
    return _imageView;
    
}

-(UILabel *)descriptionLabel
{
    if (_descriptionLabel == nil) {
        // 设置常用属性
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.textColor = [UIColor whiteColor];
        _descriptionLabel.font = [UIFont systemFontOfSize:15];
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5]; // 设置背景颜色
        [self insertSubview:_descriptionLabel aboveSubview:_imageView]; // 保证Label在imageView上面
    }
    return _descriptionLabel;

}







@end
