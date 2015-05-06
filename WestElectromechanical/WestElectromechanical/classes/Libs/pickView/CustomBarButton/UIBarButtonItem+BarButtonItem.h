//
//  UIBarButtonItem+BarButtonItem.h
//  time
//
//  Created by liwei on 15/3/6.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BarButtonItem)
+ (UIBarButtonItem *)addTarget:(id)target WithTitle:(NSString *)title withColor:(UIColor *)color action:(SEL)action;
- (UIBarButtonItem *)initTarget:(id)target WithTitle:(NSString *)title withColor:(UIColor *)color action:(SEL)action;

@end
