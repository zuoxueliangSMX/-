//
//  WEMineOrderBottomView.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEMineOrderBottomView.h"
#import "UIButton+Extension.h"
#import "ProductsM.h"
@interface WEMineOrderBottomView()
@property (nonatomic ,weak)UILabel *totalPrice;
@property (nonatomic ,weak)UIButton *orderBtn;
@end
@implementation WEMineOrderBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *totalPrice =[[UILabel alloc]init];
        totalPrice.frame =CGRectMake(  10,10,SCREEN_WIDTH*0.5,20);
        totalPrice.numberOfLines =1;
        totalPrice.font =[UIFont systemFontOfSize:18.0];
        totalPrice.backgroundColor =[UIColor clearColor];
        totalPrice.textColor =[UIColor orangeColor];
        [self addSubview:totalPrice];
        _totalPrice = totalPrice;
        
        
        UIButton *button =[UIButton addTarget:self WithNorTitle:kOrderBtnTypePay withNorColor:[UIColor whiteColor] withSelectedTitle:kOrderBtnTypePay withSelectedColor:[UIColor whiteColor] withBackgroundColor:[UIColor orangeColor] withTileSize:font(14) action:@selector(orderClick:)];
        button.frame = CGRectMake(SCREEN_WIDTH -button.size.width-20, 5, button.size.width+10, 30);
        [self addSubview:button];
        _orderBtn = button;
    }
    return self;
}

- (void)setOrderModel:(OrderM *)orderModel
{
    _orderModel = orderModel;
//    待付款  ，
//    待收货  ，
//    待评价  ，
//    待发货  ，
//    待评价  ，
    
    _totalPrice.text =[NSString stringWithFormat:@"总计:￥ %@",orderModel.all_money];
    if ([orderModel.order_state isEqualToString:@"待付款"]) {
        [_orderBtn setTitle:kOrderBtnTypePay forState:UIControlStateNormal];
        [_orderBtn setTitle:kOrderBtnTypePay forState:UIControlStateHighlighted];

    }else if ([orderModel.order_state isEqualToString:@"待收货"]||[orderModel.order_state isEqualToString:@"待发货"]||[orderModel.order_state isEqualToString:@"配送中"])
    {
        [_orderBtn setTitle:kOrderBtnTypeConfirm forState:UIControlStateNormal];
        [_orderBtn setTitle:kOrderBtnTypeConfirm forState:UIControlStateHighlighted];
    }else if ([orderModel.order_state isEqualToString:@"待评价"])
    {
        [_orderBtn setTitle:kOrderBtnTypeComment forState:UIControlStateNormal];
        [_orderBtn setTitle:kOrderBtnTypeComment forState:UIControlStateHighlighted];
    }else if ([orderModel.order_state isEqualToString:@"已完成"]){
        [_orderBtn setTitle:@"已完成" forState:UIControlStateNormal];
        [_orderBtn setTitle:@"已完成" forState:UIControlStateHighlighted];
    }
    
}

- (void)setOrderBottomViewBlock:(orderBottomViewBlock)block
{
    _block = block;
}

- (void)orderClick:(UIButton *)btn
{
    if (_block) {
        _block(btn);
    }
    
}

@end
