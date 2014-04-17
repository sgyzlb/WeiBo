//
//  SendStatusViewController.m
//  WeiBo
//
//  Created by Aven on 3/23/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "SendStatusViewController.h"

@interface SendStatusViewController ()

@end

@implementation SendStatusViewController

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
   // 1
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // 2 左边item
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cencal)];
    self.navigationItem.leftBarButtonItem = left;
    // 3  customButton
    /*
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 3.1 按钮文字
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    btn.titleLabel.font  = [UIFont systemFontOfSize:15];
    // 3.2 按钮图片
//    [btn setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_send_background.png"] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_send_background_highlighted.png"] forState:UIControlStateHighlighted];
    
    [btn setAllStateBg:@"compose_emotion_table_send_normal.png"];
    
    // 3.3 按钮边框
    btn.bounds = CGRectMake(0, 0, 50, 30);
    // 3.4 监听器
    [btn addTarget:self action:@selector(sendStatus) forControlEvents:UIControlEventTouchUpInside];
    
    // 3 右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
     */
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithBg:@"compose_emotion_table_send_normal.png" title:@"发送" size:CGSizeMake(6, 30) addTarget:self action:@selector(sendStatus)];
}

#pragma mark 发微博界面：sendStatus
-(void)sendStatus
{

}

#pragma mark 发微博界面：cencal
-(void)cencal
{
    [self dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"取消发送");  
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
