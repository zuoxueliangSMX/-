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
@end
