//
//  StatuesCellFrame.m
//  WeiBo
//
//  Created by Aven on 4/2/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

//// 昵称的字体
//#define kScreenNameFont       [UIFont systemFontOfSize:17]
//// 时间的字体
//#define kTimeFont       [UIFont systemFontOfSize:13]
//// 正文字体
//#define kContentFont       [UIFont systemFontOfSize:17]
///*
// 被转发的微博
// 
// */
//// 被转发昵称的字体
//#define kRetweetScreenNameFont       [UIFont systemFontOfSize:15]
//// 被转发微博正文的字体
//#define kRetweeContentFont       [UIFont systemFontOfSize:15]




// 边框的宽度
#define kCellBorederWidth    10
// 头像的尺寸
//#define kIconWidth               40
//#define kIconHeight              40

// 皇冠尺寸
#define kMBIconHeight         14
#define kMBIconWidth         14

// 配图尺寸
#define kImageWidth            120
#define kImageHeight            120

#import "StatuesCellFrame.h"
#import "Status.h"
#import "User.h"
#import "IconView.h"
#import "StatuesImageListView.h"

@implementation StatuesCellFrame

-(void)setStutes:(Status *)stutes
{
    _stutes = stutes;
#warning cellWidth没用到
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 2 * kTableBorderWidth;
    
    
   /*
    微博本身的子空间
    */
    // 1 头像
    CGFloat iconX = kCellBorederWidth;
    CGFloat iconY = kCellBorederWidth;
    _avatar = CGRectMake(iconX, iconY, kIconSmallWidth + kVerifiedWidth * 0.5 , kIconSmallHeight + kVerifiedHeight * 0.5);
//    _avatar = (CGRect){{iconX,iconY},[IconView iconViewSizeWithType:IconViewTypeSmall]};
//    NSLog(@"%d",IconViewTypeSmall);
//    NSLog(@"%f",_avatar.size.height);
//    
    // 2 昵称
    CGFloat screenNameX = CGRectGetMaxX(_avatar) + kCellBorederWidth;
    CGFloat screenNameY = iconY;
    NSDictionary *attributesScreenName = @{NSFontAttributeName:kScreenNameFont};
    CGSize screenNameSize = [stutes.user.screenName sizeWithAttributes:attributesScreenName];
    _screenName = (CGRect){{screenNameX,screenNameY},screenNameSize};
    
    // 3 会员图标
    CGFloat mbIconX = CGRectGetMaxX(_screenName) + kCellBorederWidth;
    CGFloat mbIconY =  CGRectGetMidY(_screenName) - kMBIconHeight * 0.5;
    _mbIcon = CGRectMake(mbIconX, mbIconY, kMBIconWidth, kMBIconHeight);
    

    
    // 6 正文的frAME
    CGFloat contentX = iconX;
    CGFloat contentY = CGRectGetMaxY(_avatar) + kCellBorederWidth;
    CGFloat contentMaxWidth = [UIScreen mainScreen].bounds.size.width - 2 * kCellBorederWidth;
//    NSDictionary *attributesContent = @{NSFontAttributeName:kTimeFont};
//    CGSize contentSize = [stutes.user.screenName sizeWithAttributes:attributesContent];
#warning 正文frame有问题
//    NSDictionary *attributesContent = @{NSFontAttributeName:kContentFont};
//    CGSize contentSize = [stutes.retweetedStatus.text boundingRectWithSize:CGSizeMake(contentMaxWidth, MAXFLOAT)  options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributesContent context:nil].size;
    CGSize contentSize = [stutes.text sizeWithFont:kContentFont constrainedToSize:CGSizeMake(contentMaxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    _content = (CGRect){{contentX,contentY},contentSize};

    // 7 配图
    if (stutes.picurls.count) {
        
        CGFloat imageX = contentX;
        CGFloat imageY = CGRectGetMaxY(_content) + kCellBorederWidth;
        
        CGSize imageSize = [StatuesImageListView imageSizeWithCount:stutes.picurls.count];
        _image = (CGRect){{imageX,imageY},imageSize};
        
        
//        _image =(CGRect){{imageX,imageY},kImageWidth,kImageHeight};
        
    }
    
    // 8 被转发的微博
    if (stutes.retweetedStatus) {
        CGFloat retweetX = contentX;
        CGFloat retweetY = CGRectGetMaxY(_content) + kCellBorederWidth;
//        NSLog(@"re高度 = %f",retweetY);
        CGFloat retweetWidth =  [UIScreen mainScreen].bounds.size.width - 2 * kCellBorederWidth;
        CGFloat retweetHeight = kCellBorederWidth;
        
        
        // 1 昵称
        CGFloat retweetScreenNameX = kCellBorederWidth;
        CGFloat retweetScreenNameY = kCellBorederWidth;
        NSString * retweetScreenName = [NSString stringWithFormat:@"@%@",stutes.user.screenName];
        NSDictionary *attributesretweetScreenName = @{NSFontAttributeName:kRetweetScreenNameFont};
        CGSize retweetScreenNameSize = [retweetScreenName sizeWithAttributes:attributesretweetScreenName];
//        CGSize retweetScreenNameSize = [retweetScreenName sizeWithFont:kRetweetScreenNameFont];
        _retweetScreenName = (CGRect){{retweetScreenNameX,retweetScreenNameY},retweetScreenNameSize};
       
        
        // 2 文本
        CGFloat retweetContentX = retweetScreenNameX;
        CGFloat retweetContentY =  CGRectGetMaxY(_retweetScreenName) + kCellBorederWidth;
        CGFloat retweettContentMaxX = retweetWidth - 2 *kCellBorederWidth;
        CGSize retweetContentXSize = [stutes.retweetedStatus.text sizeWithFont:kRetweeContentFont constrainedToSize:CGSizeMake(retweettContentMaxX, MAXFLOAT) ];
//        NSDictionary *attributesretweetContent = @{NSFontAttributeName:kRetweeContentFont};
//        CGSize retweetContentXSize = [stutes.retweetedStatus.text boundingRectWithSize:CGSizeMake(retweettContentMaxX, MAXFLOAT)  options:NSStringDrawingUsesFontLeading attributes:attributesretweetContent context:nil].size;
        _retweetContent = (CGRect){{retweetContentX,retweetContentY},retweetContentXSize};
        
        // 3 配图
        if (stutes.retweetedStatus.picurls.count) {
            CGFloat retweetImageX = retweetContentX;
            CGFloat retweetImageY = CGRectGetMaxY(_retweetContent) + kCellBorederWidth;
            
            CGSize imageSize = [StatuesImageListView imageSizeWithCount:stutes.picurls.count];
            _retweetImage = (CGRect){{retweetImageX,retweetImageY},imageSize};
        
            
//            _retweetImage = CGRectMake(retweetImageX, retweetImageY, kImageWidth, kImageHeight);
            
            retweetHeight += CGRectGetMaxY(_retweetImage) ;
        }else{ // 没有配图
            retweetHeight  += CGRectGetMaxY(_retweetContent) ;
            
        }
        
        // 4 被转发微博的总体高度
        _retweet = CGRectMake(retweetX, retweetY, retweetWidth, retweetHeight);
        
    }
    
    // 9 微博的总高度
    if (stutes.retweetedStatus) { // 有转发
        _cellHeight = CGRectGetMaxY(_retweet) + kCellBorederWidth + 40;
    }else if (stutes.picurls.count){ // 有配图
        _cellHeight = CGRectGetMaxY(_image) + kCellBorederWidth ;
    }else{
        // 只有文本
        _cellHeight = CGRectGetMaxY(_content) + kCellBorederWidth ;
    }

    
    
}








@end
