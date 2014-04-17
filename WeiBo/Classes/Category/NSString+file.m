//
//  NSString+file.m
//  WeiBo
//
//  Created by Aven on 3/23/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "NSString+file.h"

@implementation NSString (file)
-(NSString *)fileNameAppend:(NSString *)append
{
    // 1 拿文件名
    NSString *filename =  [self stringByDeletingPathExtension];
    // 2 拼接字符串 append
    filename = [filename stringByAppendingString:append];
//    NSLog(@"  filename = %@",filename);
    // 3 拼接扩展名
    NSString *extension = [self pathExtension];
//     NSLog(@"sel.path = %@",extension);
    // 4 生成新的文件名
   NSString *newName = [filename stringByAppendingPathExtension:extension];
//    NSLog(@"newName = %@",newName);

    return newName;
}
@end
