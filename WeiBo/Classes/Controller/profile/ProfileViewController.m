//
//  ProfileViewController.m
//  WeiBo
//
//  Created by Aven on 3/23/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "ProfileViewController.h"
#import "FriendsViewController.h"
#import "UserView.h"
#import "AccountTool.h"
#import "Account.h"

@interface ProfileViewController ()

@property (nonatomic,strong)  UserView *userView;

// 用户发布过的微博数
@property (nonatomic,strong) NSMutableArray *usInfoDataList;

@end

@implementation ProfileViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我";
    self.usInfoDataList = [NSMutableArray arrayWithCapacity:1];
    
    
    
   self.userView = [[[NSBundle mainBundle] loadNibNamed:@"UserView" owner:self options:nil] lastObject];
//    self.tableView.tableHeaderView = self.userView;
    
    
    [self loadUserInof];
    [self loadAllCountOfStatuses];

}

#pragma mark 请求数据
-(void)loadUserInof
{
    NSString *urlStr = [NSString stringWithFormat:@"users/show.json?%@=%@&uid=%@",kAccessToken,[AccountTool shareAccountTool].currentAcount.accessToken,[AccountTool shareAccountTool].currentAcount.uid];
   
    NSURLRequest *request = [NSURLRequest requestWithPath:urlStr params:nil];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        NSLog(@"JSON === %@",JSON);
        self.userView.screenName.text = JSON[@"screen_name"];
        [self.userView.avater setImageWithURL:[NSURL URLWithString:JSON[@"avatar_large"]] placeholderImage:[UIImage imageNamed:@"avatar_default.png"]];
        self.userView.description.text = JSON[@"description"];
        self.userView.city.text = JSON[@"location"];
        if ([JSON[@"gender"] isEqualToString:@"m"]) {
            self.userView.gender.image = [UIImage imageNamed:@"common_icon_male.png"];
        }else{
            self.userView.gender.image = [UIImage imageNamed:@"common_icon_female.png"];
        }
        
        // common_icon_male
        [self.tableView reloadData];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error == %@",error);
    }];
    [op start];
    
    
}

-(void)loadAllCountOfStatuses
{
#warning 粉丝 微博 好友等均为NSNumber类型的
    NSString *urlStr = [NSString stringWithFormat:@"users/show.json?%@=%@&uid=%@",kAccessToken,[AccountTool shareAccountTool].currentAcount.accessToken,[AccountTool shareAccountTool].currentAcount.uid];
    NSURLRequest *request = [NSURLRequest requestWithPath:urlStr params:nil];
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        NSLog(@"JSON-------------%@",JSON);
        self.userView.friendsCount.text = [NSString stringWithFormat:@"%@",JSON[@"friends_count"]];
        self.userView.followersCount.text = [NSString stringWithFormat:@"%@",JSON[@"followers_count"]];
        self.userView.statuses.text = [NSString stringWithFormat:@"%@",JSON[@"statuses_count"]];
        self.userView.favouritesCount.text = [NSString stringWithFormat:@"%@",JSON[@"favourites_count"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error = %@",error);
    }];
    [op start];
    

}



#pragma mark - Table view data source




-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.userView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 165;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning 测试
//    if (section == 0) {
//        return 1;
//    }
    
    return [self.userView.statuses.text integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }

#warning 测试数据
    NSString *str = [NSString stringWithFormat:@"测试%d",indexPath.row];
    cell.textLabel.text = str;
    
    return cell;
}



@end
