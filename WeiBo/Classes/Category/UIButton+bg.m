//
//  UIButton+bg.m
//  WeiBo
//
//  Created by Aven on 3/23/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "UIButton+bg.h"

@implementation UIButton (bg)
-(CGSize)setAllStateBg:(NSString *)name
{
    UIImage *normal = [ UIImage imageNamed:name];
    UIImage *highlighted = [UIImage stretchImageWithName:[name fileNameAppend:@"_highlighted"]];
    
    [self setBackgroundImage:normal forState:UIControlStateNormal];
    [self setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    // 返回图片的size
    return [UIImage imageNamed:name].size;
}
@end
