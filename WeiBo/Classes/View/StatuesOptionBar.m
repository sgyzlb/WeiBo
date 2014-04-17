//
//  StatuesOptionBar.m
//  WeiBo
//
//  Created by Aven on 4/13/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "StatuesOptionBar.h"
#import "Status.h"

@interface StatuesOptionBar ()
{
    NSInteger countNum;
}

@end

@implementation StatuesOptionBar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
 
    
    if (self) {
        // Initialization code
        
        // 背景图片
//        self.image = [UIImage stretchImageWithName:@"common_card_bottom_background_highlighted.png"];
        // 2 添加子控件
   
    
//        for (int i = 0; i < 3;  i ++) {
//            <#statements#>
//        }
        
        self.userInteractionEnabled = YES;
        
        // 添加分割线
        UIView *topDivider = [[UIView alloc] init];
        CGFloat topDividerX = 5;
        CGFloat topDividerWidth = self.frame.size.width - 2 * topDividerX;
        topDivider.frame = CGRectMake(topDividerX, 0, topDividerWidth, 1);
        topDivider.backgroundColor = [ UIColor lightGrayColor];
        [self addSubview:topDivider];
        
        
#warning mark 没有中间的分割线
        [self _addBtnWithTitle:@"转发" iconNomal:@"timeline_icon_retweet_disable.png" iconHighlightedi:@"timeline_icon_retweet.png" iconSelect:nil  index:0 addTarget:self action:@selector(_retweetStatuse) forControlEvents:UIControlEventTouchUpInside];
        [self _addBtnWithTitle:@"评论" iconNomal:@"timeline_icon_comment_disable.png"  iconHighlightedi:@"timeline_icon_comment.png"  iconSelect:nil  index:1 addTarget:self action:@selector(_comment) forControlEvents:UIControlEventTouchUpInside];
        [self _addBtnWithTitle:@"赞" iconNomal:@"timeline_icon_unlike.png" iconHighlightedi:nil  iconSelect:@"timeline_icon_like.png" index:2 addTarget:self action:@selector(_attitudes) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

#pragma mark 三个按钮的私有方法
// 转发
-(void)_retweetStatuse
{
    NSLog(@"%s",__func__);
}

// 评论
-(void)_comment
{
    NSLog(@"%s",__func__);
}
// 点赞
-(void)_attitudes
{
    NSLog(@"%s",__func__);
    UIButton *btn = (UIButton *)[self viewWithTag:1002];
    btn.selected = ! btn.isSelected;
//    if (btn.selected) {
//        countNum++;
//    }
    
}



-(void)setStatus:(Status *)status
{
    _status = status;

    //  设置转发数
    [self _setBthTitleAtIndex:0 placeholder:@"转发" count:status.repostsCount];
    NSLog(@"repostsCount = %d",status.repostsCount);
    

 
    // 设置评论数
    [self _setBthTitleAtIndex:1 placeholder:@"评论" count:   status.commentsCount];
    NSLog(@"commentsCount =%d",status.commentsCount);

    
  
    // 设点赞数
    [self _setBthTitleAtIndex:2 placeholder:@"赞" count:  status.attitudesCount];
    NSLog(@"attitudesCount = %d",status.attitudesCount);
    
}

//  设置按钮
-(void)_setBthTitleAtIndex:(int)index placeholder:(NSString *)placeholder count:(int)count
{
    
    //  设置转发数
    UIButton *btn = (UIButton *)[self viewWithTag:1000 + index];
    // 判断转发数是否大于1W
    if (count == 0) {
        NSString *title = [NSString stringWithFormat:@"%d",count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else if (count%10000 == 0) { // 整万
        NSString *title = [NSString stringWithFormat:@"%d万", count/10000];
        [btn setTitle:title forState:UIControlStateNormal];
    } else { // 非整万
        double result = (count / 1000) * 0.1;
        
        NSString *title = nil;
        if (((int)result) == 0) { // 不超过1W
            title = [NSString stringWithFormat:@"%d", count];
        } else { // 超过1W
            title = [NSString stringWithFormat:@"%.1f万", result];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }

//    [btn setBackgroundImage:[UIImage imageNamed:placeholder] forState:UIControlStateNormal];
    
    
}



-(void)_addBtnWithTitle:(NSString *)titlie iconNomal:(NSString *)iconNomal iconHighlightedi:(NSString *)Highlighted iconSelect:(NSString *)select index:(int )index  addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)event
{
    CGSize  size = self.frame.size;
    CGFloat btnWidth = size.width / 3;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //        [reweet setAllStateBg:@"timeline_icon_retweet.png"];
    [btn setImage:[UIImage imageNamed:iconNomal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:select] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:select] forState:UIControlStateSelected];
    [btn setTitle:titlie forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font =  [ UIFont systemFontOfSize:12];
    btn.frame = CGRectMake(index * btnWidth, 0, btnWidth, size.height);
    // 设置标题的间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(2, 5, 0, 0);
    btn.tag = 1000 + index; // 设置tag值
   
    [btn addTarget:target action:action forControlEvents:event];

    
    [self addSubview:btn];
    
}


@end
