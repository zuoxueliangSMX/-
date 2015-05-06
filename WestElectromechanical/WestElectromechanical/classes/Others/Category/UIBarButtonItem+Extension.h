//
//  UIView+Extension.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
- (UIBarButtonItem *)itemInitWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)addTarget:(id)target WithTitle:(NSString *)title withColor:(UIColor *)color action:(SEL)action;
- (UIBarButtonItem *)initTarget:(id)target WithTitle:(NSString *)title withColor:(UIColor *)color action:(SEL)action;

@end
