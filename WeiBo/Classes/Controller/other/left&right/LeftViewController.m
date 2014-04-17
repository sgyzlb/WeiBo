//
//  LeftViewController.m
//  testWB
//
//  Created by GML on 14-4-10.
//  Copyright (c) 2014年 GML. All rights reserved.
//

#import "LeftViewController.h"


@interface LeftViewController ()

@end

@implementation LeftViewController

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
	// Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.backgroundColor = []
    
    //设置tableviewcell背景颜色
    CGRect rect = [[self view] bounds];
    NSLog(@"%f",rect.size.height);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    [imageView setImage:[UIImage imageNamed:@"sidebar_bg"]];
   

    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = self.view.frame;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundView = imageView;
    
#warning 用广告位代替tableHeaderView
//    UIView* headerView =[[UIView alloc] initWithFrame:CGRectMake(0.0,0.0,320.0,69.0)];
//    headerView = _tableView.tableHeaderView;
//    headerView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"sidebar_bg"]];
    
    _tableView.tableHeaderView.hidden= YES;
    _tableView.tableFooterView.hidden = YES;
    
    
    _tableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    
    
    
}


-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView =[[UIView alloc] initWithFrame:CGRectMake(0.0,0.0,320.0,0)];
    headerView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sidebar_bg" ofType:@"png"]]];
    return headerView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    return cell;
}





@end
