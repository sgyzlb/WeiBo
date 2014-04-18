//
//  FriendsViewController.m
//  WeiBo
//
//  Created by GML on 14-4-17.
//  Copyright (c) 2014年 GML. All rights reserved.
//

typedef enum {
    VerifiedTypenNone = -1,
    VerifiedTypePersonal = 0,
    VerifiedTypeOrgEnterprice = 2, // 企业官方：
    VerifiedTypeOrgMedia = 3, // 媒体官方
    VerifiedTypeOrgWebsite = 5, // 网站官方
    VerifiedTypeDaren = 220  // 微博达人
}VerifiedType;

#define kFriendURL [NSString stringWithFormat:@"friendships/friends.json?%@=%@&uid=%@",kAccessToken,[AccountTool shareAccountTool].currentAcount.accessToken,[AccountTool shareAccountTool].currentAcount.uid];



#import "FriendsViewController.h"
#import "Account.h"
#import "AccountTool.h"
#import "OtherUsersCell.h"
#import "MJRefresh.h"
#import "FriendsDetailViewController.h"

@interface FriendsViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    NSString *totalNumber; // 关注数
    MJRefreshFooterView *_footer; // 下拉视图
    int count; // 单页返回的记录条数
    
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *firendsList; // 好友个数



@end

@implementation FriendsViewController

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
    
    self.view.backgroundColor = kGlobalBg;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    //初始化数组
    self.firendsList = [NSMutableArray arrayWithCapacity:10];
    
    // 初始化_footer
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = self.tableView;
    
    
    
    // 获取好友列表
    [self _loadFriendsList];
    
    
}

#pragma mark 获取好友列表
-(void)_loadFriendsList
{
    NSString *urlStr = [NSString stringWithFormat:@"friendships/friends.json?%@=%@&uid=%@",kAccessToken,[AccountTool shareAccountTool].currentAcount.accessToken,[AccountTool shareAccountTool].currentAcount.uid];
    NSURLRequest *request = [NSURLRequest requestWithPath:urlStr params:nil];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        NSLog(@"JSON === %@",JSON);
#warning JSON在这里啊啊啊啊啊啊啊
        self.firendsList = JSON[@"users"];
//        NSLog(@"firendsList.count = %d",_firendsList.count);
//        NSLog(@"第一个好友：%@",_firendsList);
        [self.tableView reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error = %@",error);
    }];
    
    [op start];
    
}

#pragma mark 判断关注的好友认证信息
-(void)_isVerified
{
    
}

#pragma mark UITableView 代理方法 和数据源方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    OtherUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell= (OtherUsersCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"OtherUsersCell" owner:self options:nil]  lastObject];
        
    }
    cell.screenName.text = _firendsList[indexPath.row][@"screen_name"];
    [cell.screenName sizeToFit];
    cell.screenName.textColor = kScreenNameColor;
    cell.statuses.text = [NSString stringWithFormat:@"%@",_firendsList[indexPath.row][@"statuses_count"]];
    cell.followersCount.text = [NSString stringWithFormat:@"%@",_firendsList[indexPath.row][@"followers_count"]];
    [cell.avater setImageWithURL:[NSURL URLWithString:self.firendsList[indexPath.row][@"avatar_large"]] placeholderImage:[UIImage imageNamed:@"avatar_default.png"]];

    NSString *desp = _firendsList[indexPath.row][@"description"];
    
    if ([desp isEqualToString:@""]) {
        cell.descripLabel.text = @"暂无";
    }else{
        NSString *de = [NSString stringWithFormat:@"%@",_firendsList[indexPath.row][@"description"]];
        cell.descripLabel.text = de;
    }
    
        //     判断认证信息
    NSString * verifiedType = _firendsList[indexPath.row][@"verified_type"];
    
    if ([verifiedType intValue]) {
        cell.screenName.textColor = kMBScreenNameColor;
        switch ([verifiedType intValue]) {
            case 0:
                //            NSLog(@"个人");
                cell.verifiedType.image = [UIImage imageNamed:@"avatar_vip"];
                
                break;
            case 2:
                //            NSLog(@"企业");
                cell.verifiedType.image = [UIImage imageNamed:@"avatar_enterprise_vip.png"];
                break;
                
            case 3:
                //            NSLog(@"媒体");
                cell.verifiedType.image = [UIImage imageNamed:@"avatar_enterprise_vip.png"];
                break;
            case 5:
                //            NSLog(@"官方");
                cell.verifiedType.image = [UIImage imageNamed:@"avatar_enterprise_vip.png"];
                break;
            case 220:
                //            NSLog(@"达人");
                cell.verifiedType.image = [UIImage imageNamed:@"avatar_grassroot.png"];
                break;
            default:
                break;
        }
    }
  

    
    // 是否是会员
    NSString *verified = _firendsList[indexPath.row][@"verified"];
    if ([verified boolValue]) {
        cell.screenName.textColor = kMBScreenNameColor;
        cell.isVerified.image = [UIImage imageNamed:@"common_icon_membership.png"];
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#warning 传值
    FriendsDetailViewController *detail = [[FriendsDetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning 不要写死 否则会崩
    return _firendsList.count;
}

#pragma mark MJRefresh 代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    count++;
    NSString *countStr = [NSString stringWithFormat:@"%d",count];
    NSString *urlStr = kFriendURL;
    NSURLRequest *request = [NSURLRequest requestWithPath:urlStr params:@{@"count": countStr}];
    
    
   
}

-(void)dealloc
{
    [_footer free];
}



@end
