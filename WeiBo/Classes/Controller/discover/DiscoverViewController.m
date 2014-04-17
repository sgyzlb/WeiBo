//
//  DiscoverViewController.m
//  WeiBo
//
//  Created by Aven on 3/23/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import "DiscoverViewController.h"
#import "WaterFlowCell.h"

#define kReuseIdentifier  @"cellIndentifier"
//#define kCount   arc4random_uniform(50)



@interface DiscoverViewController ()
{
    NSMutableArray *_dataList;
    
}

@end

@implementation DiscoverViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"广场";
    
    // 布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 8;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width / 2 - 5, 120);
    
    // 创建集合视图
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    // 指定集合视图重用的单元格所需的实例化类
    [collectionView registerClass:[WaterFlowCell class] forCellWithReuseIdentifier:kReuseIdentifier];
    // 设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:collectionView];
    

        
    
  
}

#pragma mark 数据源代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 105;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
#warning 测试瀑布流视图 --测试数据
    static NSString *cellIndetifier = kReuseIdentifier;
    WaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndetifier forIndexPath:indexPath];
    NSString *imgName = [NSString stringWithFormat:@"bg%d.jpg",arc4random_uniform(8)];
    cell.imgView.image = [UIImage imageNamed:imgName];
    cell.despLabel.text = @"测试啦";
    
    
    return cell;
   
    
}




@end
