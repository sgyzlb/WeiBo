//
//  StatuesViewController.m
//  WeiBo
//
//  Created by Aven on 4/13/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "StatuesDetailViewController.h"
#import "StatuesCell.h"
#import "StatuesCellFrame.h"
#import "StatuesOptionBar.h"

@interface StatuesDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)   StatuesCellFrame * statuesFrame;
// 添加UISegmentedControl的点击分类页面


@end

@implementation StatuesDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.title = @"微博详情";
    self.view.backgroundColor = kGlobalBg;
    _statuesFrame = [[StatuesCellFrame alloc] init];
    _statuesFrame.stutes = _statues;
    
    // 添加子控件
    [self _creatSubView];
    
    
}

// 布局
-(void)_creatSubView
{
    CGSize size = self.view.frame.size;
    // 1
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 0, size.width, size.height - 44);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = kGlobalBg;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableView];
    
    UIImageView *option = [[UIImageView alloc] init];
    
    
    option.image = [UIImage imageNamed:@"toolbar_background.png"];
    option.frame = CGRectMake(0, size.height - 44, size.width, 44);
    option.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:option];
}

#warning 未完成  点击 出现相应的界面
-(void)show:(UISegmentedControl *)sg
{
    int select = sg.selectedSegmentIndex;
    switch (select) {
        case 0:
            
            break;
            
        default:
            break;
    }
    
}

#pragma mark UITableView 的datasource和delegate 代理
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        if (section == 1) {
            NSArray *titleArray = [NSArray arrayWithObjects:@"转发",@"评论",@"赞", nil];
            UISegmentedControl *sg = [[UISegmentedControl alloc] initWithItems:titleArray];
            sg.selectedSegmentIndex = 1 ;//设置默认选择项索引
            sg.backgroundColor = [UIColor whiteColor];
            [sg addTarget:self action:@selector(show:) forControlEvents:UIControlEventValueChanged];

//            sg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
            return sg;
        }
        return nil;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 25;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section == 0) {
        // 返回微博详情列表
        static NSString *idetifier =  @"statuseCell";
        StatuesCell *cell = [tableView dequeueReusableCellWithIdentifier:idetifier];
        if (cell == 0) {
            cell = [[StatuesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetifier];
        
        }
        _statuesFrame = [[StatuesCellFrame alloc] init];
        _statuesFrame.stutes = _statues;
        cell.statuesCellFrame = _statuesFrame;
          return cell;
    }else{
        static NSString *cellIdentifier = @"optionCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
        cell.textLabel.text = @"测试拉";
          return cell;
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _statuesFrame.cellHeight;
    }else{
        return 44;
    }
}

@end
