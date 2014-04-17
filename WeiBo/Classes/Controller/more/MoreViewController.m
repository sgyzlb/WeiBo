//
//  MoreViewController.m
//  WeiBo
//
//  Created by Aven on 3/23/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()
@property (nonatomic,retain) NSArray *dataList;
@end

@implementation MoreViewController

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
    self.title = @"更多";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
    // 当tableview为grounplain样式时
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = kGlobalBg;
    // 缩小每一组的间距
    self.tableView.sectionFooterHeight = 5;
    self.tableView.sectionHeaderHeight  = 5;
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
    
    // 3 加载more.plist
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"more" withExtension:@"plist"];
    self.dataList =  [NSDictionary dictionaryWithContentsOfURL:url][@"zh_CN"];
    
    
    // 4 设置底部的退出按钮
    
    UIButton *btnexit = [UIButton buttonWithType:UIButtonTypeCustom];
    btnexit.frame = CGRectMake(10, 0, 300, 40);
    NSString *title =[ [self.dataList lastObject] objectAtIndex:0][@"name"];

    [btnexit setBackgroundImage:[UIImage stretchImageWithName:@"common_button_red"] forState:UIControlStateNormal];
    [btnexit setBackgroundImage:[UIImage stretchImageWithName:@"common_button_red_highlighted"] forState:UIControlStateHighlighted];
    [btnexit setTitle:title forState:UIControlStateNormal];
    btnexit.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnexit addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, 300, 60);
    [footer addSubview:btnexit];
 
    self.tableView.tableFooterView = footer;
    
    
}
#pragma mark setting更多界面 设置
-(void)setting
{
    
    
}

#pragma mark exit 更多界面
-(void)exit
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定注销此账号？" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定"/*确定按钮*/ otherButtonTitles:nil, nil];
    [sheet showInView:self.view.window]; //UIActionSheet最好写在:self.view.window上
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.dataList.count - 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *sectionArray = [self.dataList objectAtIndex:section];
    return sectionArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // 设置两种状态下的cell背景
    UIImageView *bg = [[UIImageView alloc] init];
    UIImageView *selectedbg = [[UIImageView alloc] init];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        // 先清除标签自身背景
        cell.backgroundColor = [UIColor clearColor];
      
        // 防止imagView不断被创建 现在循环里面初始化
      
    }
    
    NSString *title = [[[self.dataList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.textLabel.text = title;
    cell.backgroundView = bg;
       // 高亮状态下文字颜色
    cell.selectedBackgroundView = selectedbg;
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    
    NSArray *sectionCount = [self.dataList objectAtIndex:indexPath.section];
    int count = sectionCount.count;
    NSString *bgName = nil;
    if (count == 1) {
        bgName = @"common_card_background.png";
    }else if(indexPath.row == 0){
        bgName = @"common_card_top_background.png";
    }else if(indexPath.row == count - 1){
        bgName = @"common_card_bottom_background.png";
        
    }else{
        bgName = @"common_card_middle_background.png";
    }
    
    
    // 普通状态下
    bg.image = [UIImage stretchImageWithName:bgName];
    
    // 高粱状态下
    selectedbg.image = [UIImage stretchImageWithName:[bgName fileNameAppend:@"_highlighted"]];
    
    
    if (indexPath.section == 2) { // 阅读模式 主题
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, 100, 30);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:13];
        label.text = indexPath.row == 0 ? @"有图模式":@"主题";
        cell.accessoryView = label;
    }else{
    cell.accessoryView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow.png"]];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%d-%d",indexPath.section,indexPath.row);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
