//
//  StatuesCell.m
//  WeiBo
//
//  Created by Aven on 4/1/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "StatuesCell.h"
#import "StatuesCellFrame.h"
#import "Status.h"
#import "User.h"
//#import <QuartzCore/QuartzCore.h>
#import "IconView.h"
#import "StatuesImageListView.h"
#import "StatuesOptionBar.h"

@interface StatuesCell ()
{
    /*
     微博本身的子控件
     */
    
    // 1 头像
    
    IconView *_avatar;
    
    // 2 昵称
    UILabel *_screenName;
    
    // 3 会员皇冠图标
    UIImageView *_mbIcon;
    
    // 4 时间
    UILabel *_time;
    
    // 5 来源
    UILabel *_source;
    
    // 6 正文
    UILabel *_content;
    
    // 7 配图
    StatuesImageListView *_image;
    
    /*
     被转发微博的子控件
     */
    
    // 被转发微博的整体结构
    UIImageView  *_retweet;
    
      // 1 昵称
    UILabel *_retweetScreenName;
    
    // 3 正文
    UILabel *_retweetContent;
    
    // 4 配图
    StatuesImageListView *_retweetImage;
    
    
    // 操作条
    StatuesOptionBar *_option;
    
}

@end

@implementation StatuesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.userInteractionEnabled = YES;
        
        // 1 添加微博本身的子空间
        [self addStatuesSubViews];
        
        // 2 添加转发微博的子控件
        [self addRetweetStatuesSubViews];
        
        // 3 添加其他
        [self addOtherSubViews];
        
        [self setBg];
        
        CGRect frame = self.frame;
        frame.origin.x = 50 ;
        self.frame = frame;
        
        
    }
    return self;
}

#pragma mark 重写setFrame方法 自己调整cell的frame
-(void)setFrame:(CGRect)frame
{
//    NSLog(@"%@",NSStringFromCGRect(frame));
    frame.origin.x = kTableBorderWidth;
    frame.size.width -= kTableBorderWidth * 2;
    frame.origin.y += 5;
    frame.size.height -= 5;
    [super setFrame:frame];
    
}



#pragma mark 设置图片背景
-(void)setBg
{
    // 1 默认背景
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage stretchImageWithName:@"common_card_background 2.png"];
    self.backgroundView = bg;
    
    // 2 选中背景
    UIImageView *selectedBg = [[UIImageView alloc] init];
    selectedBg.image = [UIImage stretchImageWithName:@"common_card_bottom_background_highlighted 2.png"];
    
    self.selectedBackgroundView = selectedBg;
}


#pragma mark 添加微博本身的子空间
-(void)addStatuesSubViews
{
    // 1 头像
    _avatar = [[IconView alloc] init];
//    _avatar.layer.cornerRadius = 5;
//    _avatar.layer.masksToBounds = YES; // 很重要
//    _avatar.iconViewType = IconViewTypeSmall;
    NSLog(@"%f",_avatar.bounds.size.height);
    [self.contentView addSubview:_avatar];
    
    // 2 昵称
    _screenName = [[UILabel alloc] init];
     _screenName.backgroundColor = [UIColor clearColor];
    _screenName.font = kScreenNameFont;
    [self.contentView addSubview:_screenName];
    // 3 会员皇冠图标
    _mbIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_mbIcon];
    // 4 时间
    _time = [[UILabel alloc] init];
     _time.backgroundColor = [UIColor clearColor];
    _time.font = kTimeFont;
    [self.contentView addSubview:_time];
    
    // 5 来源
    _source = [[UILabel alloc] init];
     _source.backgroundColor = [UIColor clearColor];
    _source.font = kSourceFont;
    [self.contentView addSubview:_source];
    // 6 正文
    _content = [[UILabel alloc] init];
    _content.font = kContentFont;
    _content.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_content];
    
    // 7 配图
    
    _image = [[StatuesImageListView alloc] init];
    _image.contentMode = UIViewContentModeScaleAspectFit; // 图片适应 不被拉伸
    
    [self.contentView addSubview:_image];
    
}
#pragma mark  添加转发微博的子控件
-(void)addRetweetStatuesSubViews
{
    
    // 被转发微博的整体结构
    _retweet = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_retweet];
    
    // 1 昵称
    _retweetScreenName= [[UILabel alloc] init];
    _retweetScreenName.font = kRetweetScreenNameFont;
     _retweetScreenName.backgroundColor = [UIColor clearColor];
    [_retweet addSubview:_retweetScreenName];

    
    // 3 正文
    _retweetContent = [[UILabel alloc] init];
    _retweetContent.numberOfLines  = 0 ;
    _retweetContent.font = kRetweeContentFont;
     _retweetContent.backgroundColor = [UIColor clearColor];
    [_retweet addSubview:_retweetContent];

    
    // 4 配图
    _retweetImage =  [[StatuesImageListView alloc] init];
    _retweetImage.contentMode = UIViewContentModeScaleAspectFit; // 图片适应 不被拉伸
    [_retweet addSubview:_retweetImage];
    
    // 被转发微博的背景图片
        _mbIcon.image = [UIImage imageNamed:@"common_icon_membership.png"];
    
    UIImage *retweetImage = [UIImage imageNamed:@"common_card_bottom_background_highlighted.png"];
    retweetImage = [retweetImage stretchableImageWithLeftCapWidth:retweetImage.size.width * 0.9 topCapHeight:retweetImage.size.height * 0.5];
    _retweet.image = retweetImage;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    
}
#pragma mark 添加其他
-(void)addOtherSubViews
{
    // 1 添加操作条
    // 设置条高度
    CGFloat height = 40;
    CGFloat y = self.frame.size.height - height;
    CGRect frame = CGRectMake(0,y , self.frame.size.width, height);
    _option = [[StatuesOptionBar alloc] initWithFrame:frame];
    // 伸缩跟父控件顶部的距离，其他间距固定
    _option.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;

    
       [self.contentView addSubview:_option];


}

-(void)setStatuesCellFrame:(StatuesCellFrame *)statuesCellFrame
{
    _statuesCellFrame = statuesCellFrame;
    Status *status =  statuesCellFrame.stutes;
    User *user = status.user;
    /*
     微博本身
     */
    
    // 1 头像
    _avatar.frame = statuesCellFrame.avatar;
//    [_avatar setImageWithURL:[NSURL URLWithString:user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"avatar_default.png"] options:SDWebImageDownloaderLowPriority || SDWebImageRetryFailed];
//
    _avatar.user = user;
    // 2 昵称
    _screenName.frame = statuesCellFrame.screenName;
    _screenName.text = user.screenName;
    
    if (user.mbType == MBTypeNone ) {
    // 隐藏会员皇冠
        _mbIcon.hidden = YES;
        // 显示名称颜色
        _screenName.textColor = kScreenNameColor;
    }else
    {
        // 显示会员皇冠
        _mbIcon.hidden = NO;
        _screenName.textColor = kMBScreenNameColor;
        
    }

    
    // 3 会员皇冠图标
    _mbIcon.frame = statuesCellFrame.mbIcon;

    // 4 时间
    _time.text = status.createdAt;
    _time.textColor = kTimeColor;
    
    /*
     每次计算frame
     
     */
    // 4.时间
    CGFloat timeX = statuesCellFrame.screenName.origin.x;
    CGFloat timeY = CGRectGetMaxY(statuesCellFrame.screenName) + kCellBorderWidth - 3;
    //    NSDictionary *attributesTime = @{NSFontAttributeName:[UIFont systemFontOfSize:10]};
    CGSize timeSize = [_time.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _time.frame = (CGRect){ {timeX, timeY}, timeSize};
    
    // 5 来源
    CGFloat sourceX = CGRectGetMaxX(_time.frame) + kCellBorderWidth;
    CGFloat sourecY = timeY;
    NSDictionary *attributesSource = @{NSFontAttributeName:kSourceFont};
    CGSize sourceSize = [status.source sizeWithAttributes:attributesSource];
    _source.frame = (CGRect){{sourceX,sourecY},sourceSize};
    
    // 5 来源
//    _source.frame = statuesCellFrame.source;
    _source.text = status.source;
    // 6 正文
    _content.frame = statuesCellFrame.content;
    _content.text = status.text;
    _content.numberOfLines = 0;

    
    // 7 配图
    if (status.picurls.count) {
        _image.hidden = NO;
        
//        NSLog(@"%@",status.picurls);
        _image.frame = statuesCellFrame.image;
                  NSString *imageUrl =  status.picurls[0][@"thumbnail_pic"];
        
        // 设置图片列表数据
        _image.imageUrls = status.picurls;
        
//            [_image setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"] options:SDWebImageDownloaderLowPriority || SDWebImageRetryFailed];

    }else{
        _image.hidden = YES;
    }
   
 
    
    /*
     被转发微博本身
     */
    if (status.retweetedStatus) {
        _retweet.hidden = NO;
        
        _retweet.frame = statuesCellFrame.retweet;
        
        //    _retweet.image = [UIImage stretchImageWithName:@"timeline_retweet_background.png"];
        
        
        // 1 昵称
        _retweetScreenName.frame = statuesCellFrame.retweetScreenName;
        _retweetScreenName.text = [NSString stringWithFormat:@"@%@",status.retweetedStatus.user.screenName];
      
        _retweetScreenName.textColor = kRetweetScreenNameColor;
//        NSLog(@"retweetScreenNameSize = %@",_retweetScreenName);
        
        // 3 正文
        _retweetContent.frame = statuesCellFrame.retweetContent;
        _retweetContent.text = status.retweetedStatus.text;
        
        
        // 4 配图
//        _retweetImage.frame = statuesCellFrame.retweetImage;
        
        if (status.retweetedStatus.picurls.count) {
            _retweetImage.hidden = NO;
            
//            NSLog(@"%@",status.picurls);
    
//            NSString *imageUrl =  status.retweetedStatus.picurls[0][@"thumbnail_pic"];
            
            _retweetImage.frame = statuesCellFrame.retweetImage;
            _retweetImage.imageUrls = status.retweetedStatus.picurls;
            
//            [_retweetImage setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"] options:SDWebImageDownloaderLowPriority || SDWebImageRetryFailed];
//            
        }else{
            _retweetImage.hidden = YES;
        }

        
        
    }else{
        _retweet.hidden = YES;
    }
 

    /*
     操作条
     */
    _option.status = status;
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
