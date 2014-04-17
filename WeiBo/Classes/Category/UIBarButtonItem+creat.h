//
//  UIBarButtonItem+creat.h
//  WeiBo
//
//  Created by Aven on 3/23/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (creat)
+(UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon  addTarget:(id)target action:(SEL)action;
+(UIBarButtonItem *)barButtonItemWithBg:(NSString *)icon  title:(NSString *)title size:(CGSize)size addTarget:(id)target action:(SEL)action;
@end
