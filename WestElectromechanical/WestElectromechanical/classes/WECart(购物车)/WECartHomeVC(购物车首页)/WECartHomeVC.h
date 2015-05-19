//
//  WECartVC.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    WECartHomeTypeNormal,
    WECartHomeTypeAdd,
    WECartHomeTypePay,
}WECartHomeType;
@interface WECartHomeVC : UIViewController
@property (nonatomic ,assign)WECartHomeType cartType;
@end
