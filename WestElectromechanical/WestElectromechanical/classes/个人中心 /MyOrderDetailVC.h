//
//  MyOrderDetailVC.h
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/11.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderM.h"
#import "WEOrderDetailM.h"
@interface MyOrderDetailVC : UIViewController
@property(nonatomic,strong)  WEOrderDetailM *wm;
@property(nonatomic,strong)OrderM *om;
@end
