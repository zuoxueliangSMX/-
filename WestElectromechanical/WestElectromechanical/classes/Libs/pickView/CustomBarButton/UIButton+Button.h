//
//  UIButton+Button.h
//  time
//
//  Created by zuo on 15/3/21.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Button)
+ (UIButton *)addTarget:(id)target WithTitle:(NSString *)title withColor:(UIColor *)color action:(SEL)action;
- (UIButton *)initTarget:(id)target WithTitle:(NSString *)title withColor:(UIColor *)color action:(SEL)action;

+ (UIButton *)addTarget:(id)target
           WithNorTitle:(NSString *)title
           withNorColor:(UIColor *)color
      withSelectedTitle:(NSString *)selectedTitle
      withSelectedColor:(UIColor *)selectedColor
           withTileSize:(UIFont *)font
                 action:(SEL)action;
- (UIButton *)initTarget:(id)target
           WithNorTitle:(NSString *)title
           withNorColor:(UIColor *)color
      withSelectedTitle:(NSString *)selectedTitle
      withSelectedColor:(UIColor *)selectedColor
            withTileSize:(UIFont *)font
                 action:(SEL)action;
+ (UIButton *)addTarget:(id)target
           WithNorTitle:(NSString *)title
           withNorColor:(UIColor *)color
      withSelectedTitle:(NSString *)selectedTitle
      withSelectedColor:(UIColor *)selectedColor
    withBackgroundColor:(UIColor *)backgroundColor
           withTileSize:(UIFont *)font
                 action:(SEL)action;

- (UIButton *)initTarget:(id)target
           WithNorTitle:(NSString *)title
           withNorColor:(UIColor *)color
      withSelectedTitle:(NSString *)selectedTitle
      withSelectedColor:(UIColor *)selectedColor
    withBackgroundColor:(UIColor *)backgroundColor
           withTileSize:(UIFont *)font
                  action:(SEL)action;
@end
