//
//  LeftViewController.h
//  testWB
//
//  Created by GML on 14-4-10.
//  Copyright (c) 2014年 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;


@end
