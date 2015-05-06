//
//  PAPickView.h
//  time
//
//  Created by zuo on 15/4/2.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PALocation.h"
typedef void(^PAPickViewBlock) (NSInteger tag);
@interface PAPickView : UIView
{
    __strong PAPickViewBlock _block;
}
@property (nonatomic ,strong)PALocation *location;
- (void)setPAPickViewBlock:(PAPickViewBlock)block;
- (void)showInView:(UIView *)view;
- (void)cancelPicker;
@end
