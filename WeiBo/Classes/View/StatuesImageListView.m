//
//  StatuesImageListView.m
//  WeiBo
//
//  Created by Aven on 4/9/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#define kStatuesImageWidth   80
#define kStatuesImageHeight  80
#define kImageMargin              10
#define kStatusOneImageWidth 120
#define kStatusOneImageHeight  120

#import "StatuesImageListView.h"
#import "StatuesImageView.h"

@implementation StatuesImageListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    // 先添加9个图片 再根据实际情况调整
        for (int  i= 0; i < 9; i++) {
            StatuesImageView *imageView = [[StatuesImageView alloc] init];
           
            
            [self addSubview:imageView];
        }
        
    }
    return self;
}

-(void)setImageUrls:(NSArray *)imageUrls
{
    _imageUrls = imageUrls;
    int imageCount = imageUrls.count;
    int subCount = self.subviews.count;
    // 遍历所有的imageView
    for (int i = 0; i < subCount; i++) {
        // 1 取出对应图片的控件
        StatuesImageView *s = self.subviews[i];
        
        // 2 i 位子对应的控件没有图片
        if (i >= imageCount) {
            s.hidden = YES;
        }else{
            s.hidden = NO;
            
            
            if (imageCount == 1) {
                s.frame = CGRectMake(0, 0, kStatuesImageWidth, kStatuesImageHeight);
                s.contentMode = UIViewContentModeScaleAspectFit;
                
            }else{
                // 设置frame
                int div = imageCount == 4 ? 2:3;
                
                // 列数 决定X
                int colum = i %div;
                // 行数 决定Y
                int row = i / div;
                
                int sX = colum * (kStatuesImageWidth + kImageMargin);
                int sY = row * (kStatuesImageHeight + kImageMargin);
                
                s.frame = CGRectMake(sX, sY, kStatuesImageWidth, kStatuesImageHeight);

                s.contentMode = UIViewContentModeScaleToFill;
            }
            
            
            
            
            // 4 设置图片的URL
            s.url = [[imageUrls objectAtIndex:i ] objectForKey:@"thumbnail_pic"];
//            NSLog(@"%@",s.url);
            
        }
        
    }
}

+ (CGSize)imageSizeWithCount:(int)count
{
    if (count == 1) return CGSizeMake(kStatusOneImageWidth, kStatusOneImageHeight);
    
    // 1.总行数
    int rows = (count + 2) / 3;
    
    // 2.总高度
    CGFloat height = rows * kStatuesImageHeight + (rows - 1) * kImageMargin;
    
    // 3.总列数
    int columns = (count>=3) ? 3 : count;
    
    // 4.总宽度
    CGFloat width = columns * kImageWidth + (columns - 1) * kImageMargin;

    return CGSizeMake(width, height);
    
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
