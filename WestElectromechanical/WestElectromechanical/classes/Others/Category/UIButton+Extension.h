//
//  UIButton+Extension.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/6.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
- (UIButton *)buttonInitWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
+ (UIButton *)buttonWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
+ (UIButton *)buttonWithBgImageName:(NSString *)imageName bgHighImageName:(NSString *)highImageName title:(NSString *)title selectedTitle:(NSString *)selectedTitle target:(id)target action:(SEL)action;

- (UIButton *)buttonInitWithBgImageName:(NSString *)imageName bgHighImageName:(NSString *)highImageName title:(NSString *)title selectedTitle:(NSString *)selectedTitle target:(id)target action:(SEL)action;


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
