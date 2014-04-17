//
//  WaterFlowCellView.h
//  WeiBo
//
//  Created by Aven on 4/17/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  模拟UITableViewCell
 */
@interface WaterFlowCellView : UIView
//
@property (nonatomic,strong) UIImageView *imageView; // 视图
@property (nonatomic,strong) UILabel *descriptionLabel; // 文字描述
@property (nonatomic,strong) NSString *reuseIdentifier; // 可重用标志符
@property (nonatomic,assign) BOOL selectes; // 选中标记

// 使用可重用标识符 实例化单元格
-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
