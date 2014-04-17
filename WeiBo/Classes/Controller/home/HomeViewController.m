//
//  HomeViewController.m
//  WeiBo
//
//  Created by Aven on 3/23/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "HomeViewController.h"
#import "SendStatusViewController.h"
#import "Account.h"
#import "AccountTool.h"
#import "Status.h"
#import "StatueToolResques.h"
#import "User.h"
#import "MJRefresh.h"
#import "StatuesCell.h"
#import "Status.h"
#import "StatuesCellFrame.h"
#import "StatuesDetailViewController.h"

@interface HomeViewController ()<MJRefreshBaseViewDelegate>
{
//    NSMutableArray *_statuses;
    NSMutableArray *_statusesCellFrame; // frame 数据
    
//    UIRefreshControl *_refresh;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    
}

@end

@implementation HomeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
BarButtonItem要显示图片 用initWithCustomView：方法
 BarButtonItem要显示文字 用、：initWithTitle:方法
 */




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // MJ的刷新第三方
    // 0 添加下拉刷新和上提加载
    _header = [[MJRefreshHeaderView alloc] init];
    _header.delegate = self;
    [_header beginRefreshing];
    _header.scrollView  = self.tableView;
    
   _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = self.tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.title = @"微博正文";
  /*
//    self.title = @"首页";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // 1 左边按钮
//    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *leftNormal = [UIImage imageNamed:@"navigationbar_compose"]; // 图片大小决定leftButton大小
//    CGSize leftSize = [left setAllStateBg:@"navigationbar_compose.png"];
//    [left setAllStateBg:@"navigationbar_compose"];
//    [left setBackgroundImage:[UIImage imageNamed:@"navigationbar_compose"] forState:UIControlStateNormal];
//    [left setBackgroundImage:[UIImage imageNamed:@"navigationbar_compose_highligted"] forState:UIControlStateHighlighted];
//    left.bounds = (CGRect) {CGPointZero,leftSize};
//    [left addTarget:self action:@selector(sendStatus) forControlEvents:UIControlEventTouchUpInside];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    */
    // 以上代码封装成下面方法 ↓
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_compose.png" addTarget:self action:@selector(sendStatus)];
    /*
    // 2 右边按钮
//    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
//      CGSize rightSize = [right setAllStateBg:@"navigationbar_pop.png"];
//    right.bounds = (CGRect) {CGPointZero,rightSize};
//    [right addTarget:self action:@selector(sendStatus) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
     */
    // 以上代码封装成下面方法 ↓
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_pop.png" addTarget:self action:@selector(popMenu)];
    
    // 4 请求数据 创建数组
//    _statuses = [NSMutableArray array];
    _statusesCellFrame = [NSMutableArray array];
   
    
}

#pragma mark showNewStatuesCount 
-(void)showNewStatuesCount:(int )num
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage stretchImageWithName:@"timeline_new_status_background.png"] forState:UIControlStateNormal];
    
  
    NSString *text = @"暂时没有新微博";
    if (num == 0) {
        [btn setTitle:text forState:UIControlStateNormal];
    }else{
        text = [NSString stringWithFormat:@"刷新了%d条微博",num];
        [btn setTitle:text forState:UIControlStateNormal];
    }
    
    btn.titleLabel.text  = [NSString stringWithFormat:@"刷新了%d条微博",num];
    btn.titleLabel.textAlignment = 1;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    CGFloat btnWidth = self.view.frame.size.width;
    CGFloat btnHeight = 50;
    
    btn.frame = CGRectMake(0, -btnHeight, btnWidth, btnHeight);
    // 将btn加到导航控制栏中
    [self.navigationController.view addSubview:btn];
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnHeight);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 animations:^{
            btn.transform = CGAffineTransformIdentity;
            
        }];

    }];
    
   
    
    
}


#pragma mark 下拉刷新要做的事情
- (void)refreshData
{
    // 加载ID>sinceId的微博
    NSString *sinceId = nil;
    if (_statusesCellFrame.count) { // 取出最前面那条微博的id
        StatuesCellFrame *cellFrame = _statusesCellFrame[0];
        sinceId = cellFrame.stutes.idstr;
    }
    
    [StatueToolResques statuesWithSinceID:sinceId maxID:nil success:^(NSMutableArray *statues) {
        // 0.告诉用户一共刷新了多少条新的微博
        [self showNewStatuesCount:statues.count];
        
        // 计算所有新微博的frame
        NSMutableArray *newFrame = [NSMutableArray array];
        for (Status *s in statues) {
            StatuesCellFrame *frame = [[StatuesCellFrame alloc] init];
            frame.stutes = s;
            [newFrame addObject:frame];
        }
        
        
        // 1.将旧数据添加到新数据的最后面
        
        
        [newFrame addObjectsFromArray:_statusesCellFrame];
        NSLog(@"_statuses ==== %@",statues);
        _statusesCellFrame = newFrame;
        
        // 2.刷新表格
        [self.tableView reloadData];
        
        [self showNewStatuesCount:_statusesCellFrame.count];
        // 3.结束下拉刷新状态
        [_header endRefreshing];
    } fail:^{
        // 结束下拉刷新状态
        [_header endRefreshing];
    }];
    

}

#pragma mark 上拉加载更多要做的事情
- (void)loadMoreData
{
    // 加载ID<=maxId的微博
    NSString *maxId = nil;
    if (_statusesCellFrame.count) { // 取出最后面那条微博的id - 1
        StatuesCellFrame *last = [_statusesCellFrame lastObject];
        
        // 这里一定要用long long
        long long lastll = [last.stutes.idstr longLongValue];
        lastll--;
        
        maxId = [NSString stringWithFormat:@"%lld", lastll];
    }
    
    [StatueToolResques statuesWithSinceID:nil maxID:maxId success:^(NSMutableArray *statues) {
        
        // 计算所有新微博的frame
        NSMutableArray *newFrame = [NSMutableArray array];
        for (Status *s in statues) {
            StatuesCellFrame *frame = [[StatuesCellFrame alloc] init];
            frame.stutes = s;
            [newFrame addObject:frame];
        }
        

         [_statusesCellFrame addObjectsFromArray:newFrame];
        
        // 2.刷新表格
        [self.tableView reloadData];
        
        // 3.结束下拉刷新状态
        [_footer endRefreshing];
    } fail:^{
        [_footer endRefreshing];
    }];
    
}



#pragma mark MJRefresh 代理方法
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_header == refreshView) { // 下拉刷新
        NSString *sinceID = nil;
        if (_statusesCellFrame.count) {
            StatuesCellFrame *first = [_statusesCellFrame objectAtIndex:0];
            sinceID = first.stutes.idstr;
        }
        
    [StatueToolResques statuesWithSinceID:sinceID maxID:nil success:^(NSMutableArray *statues) {

   
        
        // 计算所有新微博的frame
        NSMutableArray *newFrame = [NSMutableArray array];
        for (Status *s in statues) {
            StatuesCellFrame *frame = [[StatuesCellFrame alloc] init];
            frame.stutes = s;
            [newFrame addObject:frame];
        }
        
        
//        [_statusesCellFrame addObjectsFromArray:statues];
        
        
        [self showNewStatuesCount:newFrame.count];
        [newFrame addObjectsFromArray:_statusesCellFrame];
        _statusesCellFrame = newFrame;
        
//        [_statusesCellFrame addObjectsFromArray:newFrame]; // 已经在方法里面封装了statue模型
        
        // 本方法传回了一个NSMutableArray的数组 只要将原数组添加到该数组后面即可
//        [statues addObjectsFromArray:_statuses];
//        NSLog(@"statues ===== %@",statues);
        // 再让原数组等于添加后的新数组
//        _statuses = statues;
        
        // 刷新表格
        [self.tableView reloadData];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showErrorWithText:@"加载成功....." icon:@"load_success.png"];
        [_header endRefreshing];
        
    } fail:^{
        NSLog(@"封装失败");
        [MBProgressHUD hideAllHUDsForView:self.view  animated:YES];

        [MBProgressHUD showErrorWithText:@"网络不给力，加载失败......" icon:@"load_error.png"];
    
        // 加载完成后停止刷新
        [_header endRefreshing];
    }];
        
      
        
    }else{ // 上提加载
    
        NSString *maxID = nil;
        
        if (_statusesCellFrame.count) {
        
            StatuesCellFrame *last = [_statusesCellFrame lastObject];
            
           // 因为加载的ID <= maxID的微博 所以最后一条会出现两次 因此做如下改动
            // 而且一定是longlong形式的
            long  long t =   [last.stutes.idstr longLongValue];
            t--;
            
            maxID =[NSString stringWithFormat:@"%lld",t];
            
        }
    
        [StatueToolResques statuesWithSinceID:nil maxID:maxID success:^(NSMutableArray *statues) {
            
            // 计算所有新微博的frame
            NSMutableArray *newFrame = [NSMutableArray array];
            for (Status *s in statues) {
                StatuesCellFrame *frame = [[StatuesCellFrame alloc] init];
                frame.stutes = s;
                [newFrame addObject:frame];
            }
           
            // 将获取到的数据拼接到原数组中
            [_statusesCellFrame addObjectsFromArray:newFrame];

            // 刷新表格
            [self.tableView reloadData];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showErrorWithText:@"加载成功......" icon:@"load_success.png"];
            
            [_footer endRefreshing];
        
        } fail:^{
            NSLog(@"封装失败");
            [MBProgressHUD hideAllHUDsForView:self.view  animated:YES];
            
            [MBProgressHUD showErrorWithText:@"网络不给力，加载失败" icon:@"load_error.png"];
        }];

        [_footer endRefreshing];
    }
}


#pragma mark popMenu弹出菜单
-(void)popMenu
{
    
    
}

#pragma mark sendStatus 发送微博
-(void)sendStatus
{
    SendStatusViewController *sendStatus = [[SendStatusViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sendStatus ];
    [self presentViewController:nav animated:YES completion:^{
//        NSLog(@"发送微博");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

//    NSLog(@"%d",_statuses.count);
    // Return the number of rows in the section.
    return _statusesCellFrame.count;
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    StatuesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[StatuesCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    }
    cell.statuesCellFrame = _statusesCellFrame [indexPath.row];

    return cell;
}

#pragma mark 优先调用
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
//    Status *statue = [_statuses objectAtIndex:indexPath.row];
//    [statue.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(250, MAXFLOAT)];
//
//    // 根据内容返回高度
//     NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
//  CGSize size =   [statue.text boundingRectWithSize:CGSizeMake(250, MAXFLOAT) options:
//     NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
//    return size.height + 50;
    */
    //-------------------------------分割线------------------------
    // 取出微博数据 计算cell高度 同时包括所有子控件的边框
    StatuesCellFrame *frame = [_statusesCellFrame objectAtIndex:indexPath.row];
    
        return frame.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatuesDetailViewController *detail = [[ StatuesDetailViewController alloc] init];
  StatuesCellFrame *frame =  [_statusesCellFrame objectAtIndex:indexPath.row];
    detail.statues = frame.stutes;
    [self.navigationController pushViewController:detail animated:YES];
    
}


-(void)dealloc
{
    [_footer free];
    [_header free];
}

@end
