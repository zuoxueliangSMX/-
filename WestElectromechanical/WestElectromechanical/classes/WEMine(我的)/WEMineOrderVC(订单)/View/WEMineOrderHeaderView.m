//
//  WEMineOrderHeaderView.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEMineOrderHeaderView.h"
#define kMargin 5
#define kHMargin 10
#define kVMargin 10
@interface WEMineOrderHeaderView()
@property (nonatomic ,weak)UILabel *orderNum;
@property (nonatomic ,weak)UILabel *orderTime;
@property (nonatomic ,weak)UILabel *orderStutas;
@end
@implementation WEMineOrderHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *orderNum =[[UILabel alloc]init];
        orderNum.frame =CGRectMake( kHMargin,kMargin,SCREEN_WIDTH-100,15);
        orderNum.numberOfLines =1;
        orderNum.font =font(14);
        orderNum.textColor =[UIColor darkGrayColor];

        orderNum.backgroundColor =[UIColor clearColor];
        [self addSubview:orderNum];
        
        UILabel *orderTime =[[UILabel alloc]init];
        orderTime.frame =CGRectMake( kHMargin,CGRectGetMaxY(orderNum.frame)+kMargin,SCREEN_WIDTH-100,15);
        orderTime.numberOfLines =1;
        orderTime.font =font(14);
        orderTime.textColor =[UIColor darkGrayColor];
        orderTime.backgroundColor =[UIColor clearColor];
        [self addSubview:orderTime];
        
        UILabel *orderStutas =[[UILabel alloc]init];
        orderStutas.frame =CGRectMake( SCREEN_WIDTH-80,CGRectGetMinY(orderNum.frame),60,18);
        orderStutas.numberOfLines =1;
        orderStutas.font =font(15);
        orderStutas.textAlignment =2;
        orderStutas.textColor =[UIColor blueColor];
        orderStutas.backgroundColor =[UIColor clearColor];
        [self addSubview:orderStutas];
        _orderNum = orderNum;
        _orderTime = orderTime;
        _orderStutas = orderStutas;
        
    }
    return self;
}

- (void)setOrderModel:(OrderM *)orderModel
{
    _orderModel = orderModel;
    _orderNum.text = [NSString stringWithFormat:@"订单号:%@",orderModel.order_num];
    _orderTime.text = [NSString stringWithFormat:@"下单时间:%@",orderModel.order_time];
    _orderStutas.text = orderModel.order_state;
}

@end
