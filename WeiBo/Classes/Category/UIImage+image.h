//
//  UIImage+image.h
//  WeiBo
//
//  Created by Aven on 3/22/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)
+(UIImage *)fullScreenImageWithName:(NSString *)name;
// 返回一张已经拉伸号的图片
+(UIImage *)stretchImageWithName:(NSString *)name;
@end
