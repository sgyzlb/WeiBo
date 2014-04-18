//
//  OtherUsersCell.h
//  WeiBo
//
//  Created by GML on 14-4-18.
//  Copyright (c) 2014年 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherUsersCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIImageView *avater; // 头像
@property (nonatomic,strong) IBOutlet UILabel *screenName;// 用户名
@property (nonatomic,strong) IBOutlet UILabel *followersCount; // 粉丝数
@property (nonatomic,strong) IBOutlet UILabel *statuses;// 微博数
@property (strong, nonatomic) IBOutlet UILabel *descripLabel;
@property (strong, nonatomic) IBOutlet UIImageView *verifiedType;
@property (strong, nonatomic) IBOutlet UIImageView *isVerified;

@end
