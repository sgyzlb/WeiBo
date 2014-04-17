//
//  NewFeatherViewController.h
//  WeiBo
//
//  Created by Aven on 3/22/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatherViewController : UIViewController
@property (nonatomic,copy) void(^startBlock)(BOOL isShare);

@end
