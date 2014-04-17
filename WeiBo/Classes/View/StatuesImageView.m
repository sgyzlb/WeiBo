//
//  StatuesImageView.m
//  WeiBo
//
//  Created by Aven on 4/9/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "StatuesImageView.h"

@implementation StatuesImageView
{
//    // 1 配图
//    UIImageView *_imageView;
//    
    // 2 gif 标志
    UIImageView *_gifView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//     // 1 显示图片
//        
//        _imageView  = [[UIImageView alloc] init];
//        [self addSubview:_imageView];
//
        
        // 2 显示gif标志
        _gifView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
//        _gifView.image = [UIImage imageNamed:@"timeline_image_gif"];
//        _gifView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin; // 使图片距离父控件的顶部和左边的距离一定
        [self addSubview:_gifView];
        
        
    }
    return self;
}

-(void)setUrl:(NSString *)url
{
    _url = url;
    
    // 1 下载图片
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    // 2 是否显示gif
    if ([url hasPrefix:@"gif"]) {
        _gifView.hidden = NO;
        
        CGSize size = self.frame.size;
        CGSize gifSize = _gifView.frame.size;
        _gifView.center = CGPointMake(size.width - gifSize.width * 0.5, size.height - gifSize.height * 0.5);
        

    }else{
        _gifView.hidden  = YES;
    }
    
    
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
