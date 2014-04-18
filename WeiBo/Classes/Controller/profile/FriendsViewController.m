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

@interface FriendsViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    NSString *totalNumber; // 关注数
    MJRefreshFooterView *_footer; // 下拉视图
    int count; // 单页返回的记录条数
    NSArray *_searchResults; // 返回搜索结果
    NSMutableArray *_allFirendsNameList; // 好友名字列表
    
    
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *firendsList; // 好友个数
@property (nonatomic,strong) UISearchBar *searchBar; // 搜索框
@property (nonatomic,strong) UISearchDisplayController *searchDisplay; // 结果展示页

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
    
    // 初始化搜索框
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    self.searchBar.placeholder = @"在 全部关注 中搜索 ...";
    self.searchBar.delegate = self;
//    self.searchBar.showsCancelButton = YES;
    self.searchBar.keyboardType  = UIKeyboardAppearanceDefault;
    self.searchBar.backgroundColor = kGlobalBg;
    self.tableView.tableHeaderView = self.searchBar;
    [self.view addSubview:self.searchBar];

    // 初始化结果页面
    self.searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchDisplay.delegate = self;
    self.searchDisplay.searchResultsDataSource = self;
    self.searchDisplay.searchResultsDelegate = self;
    
    //初始化数组
    self.firendsList = [NSMutableArray arrayWithCapacity:10];
    _allFirendsNameList = [NSMutableArray arrayWithCapacity:10];
    _searchResults = [NSArray array];
 
    
    
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
        NSLog(@"JSON === %@",JSON);
#warning JSON在这里啊啊啊啊啊啊啊
        self.firendsList = JSON[@"users"];
//        NSLog(@"firendsList.count = %d",_firendsList.count);
//        NSLog(@"第一个好友：%@",_firendsList[6]);
         [self _allFriendsName];
        [self.tableView reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error = %@",error);
    }];
    
    [op start];
    
}

#pragma mark 获取好友名称
-(void)_allFriendsName
{
     NSMutableArray *arr = [ NSMutableArray array];
    for (int i = 0 ; i < self.firendsList.count; i ++) {
        NSString *name = self.firendsList[i][@"screen_name"];
        [arr addObject:name];
    }
    _allFirendsNameList = arr;
    NSLog(@"----------------------------------------------%@",_allFirendsNameList);
    
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
    int type = [verifiedType intValue];
    if ( type ) {
        cell.screenName.textColor = kMBScreenNameColor;
        switch ([verifiedType intValue]) {
            case 0:
                //            NSLog(@"个人");
                cell.verifiedType.image = [UIImage imageNamed:@"avatar_vip.png"];
                
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
    
    if ([tableView isEqual:self.searchDisplay.searchResultsTableView]) {
        return _searchResults.count;
    }
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

#pragma mark UISearchBar 的代理方法
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *urlStr = [NSString stringWithFormat:@"friendships/friends.json?%@=%@&uid=%@",kAccessToken,[AccountTool shareAccountTool].currentAcount.accessToken,[AccountTool shareAccountTool].currentAcount.uid];
    NSURLRequest *request = [NSURLRequest requestWithPath:urlStr params:nil];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"JSON === %@",JSON);
#warning JSON在这里啊啊啊啊啊啊
        //        NSLog(@"firendsList.count = %d",_firendsList.count);
        //        NSLog(@"第一个好友：%@",_firendsList[6]);
        [self.tableView reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error = %@",error);
    }];
    
    [op start];

}


#pragma mark UISearchDisplay 的代理方法
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller  shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]                                       objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller  shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]  scope:[[self.searchDisplayController.searchBar scopeButtonTitles]  objectAtIndex:searchOption]];
    
    return YES; 
    
}
#pragma mark 搜索信息过滤
- (void)filterContentForSearchText:(NSString*)searchText  scope:(NSString*)scope
{
    
    NSPredicate *resultPredicate = [NSPredicate  predicateWithFormat:@"SELF contains[cd] %@",  searchText];
    
    _searchResults = [_allFirendsNameList filteredArrayUsingPredicate:resultPredicate];
    
}






-(void)dealloc
{
    [_footer free];
}



@end
