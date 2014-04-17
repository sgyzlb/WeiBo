//
//  StatuesImageListView.h
//  WeiBo
//
//  Created by Aven on 4/9/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

// 多张图片
@interface StatuesImageListView : UIView
// 传入图片即可
@property (nonatomic,strong) NSArray *imageUrls;

+(CGSize)imageSizeWithCount:(int)count;


@end
