//
//  UIButton+Extension.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/6.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
- (UIButton *)buttonInitWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[self alloc] buttonInitWithImageName:imageName highImageName:highImageName target:target action:action];
    return button;
}

+ (UIButton *)addTarget:(id)target WithTitle:(NSString *)title withColor:(UIColor *)color action:(SEL)action{
    return [[self alloc]initTarget:target WithTitle:title withColor:color action:action];
    
}
- (UIButton *)initTarget:(id)target WithTitle:(NSString *)title withColor:(UIColor *)color action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:16]];
    CGSize size =[title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font(16),NSFontAttributeName, nil]];
    //! 这里需要根据内容大小来调整宽度
    button.bounds = CGRectMake(0, 0, size.width <= 10 ? 70 : size.width + 30, size.height+20);
    //button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.font = font(12);
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)addTarget:(id)target
           WithNorTitle:(NSString *)title
           withNorColor:(UIColor *)color
      withSelectedTitle:(NSString *)selectedTitle
      withSelectedColor:(UIColor *)selectedColor
           withTileSize:(UIFont *)font
                 action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:16]];
    CGSize size =[title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    //! 这里需要根据内容大小来调整宽度
    button.bounds = CGRectMake(0, 0, size.width <= 10 ? 70 : size.width + 30, size.height+20);
    //button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.font = font;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (UIButton *)initTarget:(id)target
            WithNorTitle:(NSString *)title
            withNorColor:(UIColor *)color
       withSelectedTitle:(NSString *)selectedTitle
       withSelectedColor:(UIColor *)selectedColor
            withTileSize:(UIFont *)font
                  action:(SEL)action
{
    return [UIButton addTarget:target WithNorTitle:title withNorColor:color withSelectedTitle:selectedTitle withSelectedColor:selectedColor withTileSize:font action:action];
}


- (UIButton *)initTarget:(id)target
            WithNorTitle:(NSString *)title
            withNorColor:(UIColor *)color
       withSelectedTitle:(NSString *)selectedTitle
       withSelectedColor:(UIColor *)selectedColor
     withBackgroundColor:(UIColor *)backgroundColor
            withTileSize:(UIFont *)font
                  action:(SEL)action
{
    return [UIButton addTarget:target
                  WithNorTitle:title
                  withNorColor:color
             withSelectedTitle:selectedTitle
             withSelectedColor:selectedColor
           withBackgroundColor:backgroundColor
                  withTileSize:font action:action];
}

+ (UIButton *)addTarget:(id)target
           WithNorTitle:(NSString *)title
           withNorColor:(UIColor *)color
      withSelectedTitle:(NSString *)selectedTitle
      withSelectedColor:(UIColor *)selectedColor
    withBackgroundColor:(UIColor *)backgroundColor
           withTileSize:(UIFont *)font
                 action:(SEL)action{
    UIButton *btn = [UIButton addTarget:target
                           WithNorTitle:title
                           withNorColor:color
                      withSelectedTitle:selectedTitle
                      withSelectedColor:selectedColor
                           withTileSize:font
                                 action:action];
    btn.backgroundColor =backgroundColor;
    
    return btn;
}


@end
