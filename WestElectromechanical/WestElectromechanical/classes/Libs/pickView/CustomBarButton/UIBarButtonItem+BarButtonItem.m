//
//  UIBarButtonItem+BarButtonItem.m
//  time
//
//  Created by liwei on 15/3/6.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import "UIBarButtonItem+BarButtonItem.h"

@implementation UIBarButtonItem (BarButtonItem)

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
//    button.layer.cornerRadius = 5;
//    button.layer.borderColor =[UIColor lightGrayColor].CGColor;
//    button.layer.borderWidth =0.5;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;

}
+ (UIBarButtonItem *)addTarget:(id)target WithTitle:(NSString *)title withColor:(UIColor *)color action:(SEL)action
{
    return [[self alloc]initTarget:target WithTitle:title withColor:color action:action];
}
@end
