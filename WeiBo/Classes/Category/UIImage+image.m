//
//  UIImage+image.m
//  WeiBo
//
//  Created by Aven on 3/22/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

+(UIImage *)fullScreenImageWithName:(NSString *)name
{
    if (iPhone5) {
        // 文件名中间插字符串 eg. new_feature.png
        // new_feature -> new_feature-568h@2x
        // new_feature-568h@2x.png
        
        // 1 拿文件名
        NSString *filename =  [name stringByDeletingPathExtension];
        // 2 拼接字符串
        filename = [filename stringByAppendingString:@"-568h@2x"];
        // 3 拼接扩展名
        NSString *extension = [name pathExtension];
        name = [filename stringByAppendingPathExtension:extension];

    }
    return [UIImage imageNamed:name];
}

+(UIImage *)stretchImageWithName:(NSString *)name
{
    UIImage *normal = [ UIImage imageNamed:name];
  return   [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5  topCapHeight:normal.size.height * 0.5];
    
}

@end
