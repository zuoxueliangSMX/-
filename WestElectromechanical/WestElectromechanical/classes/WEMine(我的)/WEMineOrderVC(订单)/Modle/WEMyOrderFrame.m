//
//  WEMyOrderFrame.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEMyOrderFrame.h"
#import "WEMineOrderMiddleView.h"
@implementation WEMyOrderFrame
- (void)setOrderModel:(OrderM *)orderModel
{
    _orderModel = orderModel;
    _headerFrame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    
    _middleFrame = CGRectMake(0, CGRectGetHeight(_headerFrame), SCREEN_WIDTH, 100*orderModel.order_products.count);
    _bottomFrame = CGRectMake(0, CGRectGetMaxY(_middleFrame), SCREEN_WIDTH, 40);
    _height = CGRectGetMaxY(_bottomFrame)+5;
}
@end
