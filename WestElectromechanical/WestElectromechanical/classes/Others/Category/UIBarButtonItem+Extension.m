//
//  UIView+Extension.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (UIBarButtonItem *)itemInitWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    return [self itemInitWithImageName:imageName highImageName:highImageName target:target action:action];
}


- (UIBarButtonItem *)initTarget:(id)target WithTitle:(NSString *)title withColor:(UIColor *)color action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:font(15)}];
    //! 这里需要根据内容大小来调整宽度
    button.frame = CGRectMake(0, 8, size.width <= 10 ? 50 : size.width + 20, 32);
    //button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.font = font(15);
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    button.layer.borderColor =[UIColor lightGrayColor].CGColor;
    button.layer.borderWidth =0.5;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
    
}
+ (UIBarButtonItem *)addTarget:(id)target WithTitle:(NSString *)title withColor:(UIColor *)color action:(SEL)action
{
    return [[self alloc]initTarget:target WithTitle:title withColor:color action:action];
}


- (UIBarButtonItem *)itemInitWithImageName:(NSString *)imageName withTitle:(NSString *)title  highImageName:(NSString *)highImageName withHighTitle:(NSString *)highTitle target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:font(15)}];
    //! 这里需要根据内容大小来调整宽度
    button.frame = CGRectMake(0, 8, size.width <= 10 ? 50 : size.width + 20, 32);
    //button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.font = font(15);
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    button.layer.cornerRadius = 5;
//    button.layer.borderColor =[UIColor lightGrayColor].CGColor;
//    button.layer.borderWidth =0.5;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName withTitle:(NSString *)title  highImageName:(NSString *)highImageName withHighTitle:(NSString *)highTitle target:(id)target action:(SEL)action
{
    return [[self alloc]itemInitWithImageName:imageName withTitle:title highImageName:highImageName withHighTitle:highTitle target:target action:action];
}


@end
