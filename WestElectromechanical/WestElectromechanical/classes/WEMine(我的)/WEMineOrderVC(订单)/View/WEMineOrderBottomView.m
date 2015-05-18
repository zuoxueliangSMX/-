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
        totalPrice.frame =CGRectMake(  10,15,SCREEN_WIDTH*0.5,20);
        totalPrice.numberOfLines =1;
        totalPrice.font =[UIFont systemFontOfSize:18.0];
        totalPrice.backgroundColor =[UIColor clearColor];
        totalPrice.textColor =[UIColor orangeColor];
        [self addSubview:totalPrice];
        _totalPrice = totalPrice;
        
        
        UIButton *button =[UIButton addTarget:self WithNorTitle:kOrderBtnTypePay withNorColor:[UIColor whiteColor] withSelectedTitle:kOrderBtnTypePay withSelectedColor:[UIColor whiteColor] withBackgroundColor:[UIColor redColor] withTileSize:font(14) action:@selector(orderClick:)];
        button.frame = CGRectMake(SCREEN_WIDTH *0.7+20, 5, SCREEN_WIDTH*0.2, 44);
        [self addSubview:button];
        _orderBtn = button;
    }
    return self;
}

- (void)setOrderModel:(OrderM *)orderModel
{
    _orderModel = orderModel;
    
    _totalPrice.text =[NSString stringWithFormat:@"总计:￥ %@",orderModel.all_money];
    if ([orderModel.order_state isEqualToString:@"待付款"]) {
        [_orderBtn setTitle:kOrderBtnTypePay forState:UIControlStateNormal];
        [_orderBtn setTitle:kOrderBtnTypePay forState:UIControlStateHighlighted];

    }else if ([orderModel.order_state isEqualToString:@"待发货"])
    {
        [_orderBtn setTitle:kOrderBtnTypeConfirm forState:UIControlStateNormal];
        [_orderBtn setTitle:kOrderBtnTypeConfirm forState:UIControlStateHighlighted];
    }else if ([orderModel.order_state isEqualToString:@"已完成"])
    {
        [_orderBtn setTitle:kOrderBtnTypeComment forState:UIControlStateNormal];
        [_orderBtn setTitle:kOrderBtnTypeComment forState:UIControlStateHighlighted];
    }
    
}

- (void)setOrderBottomViewBlock:(orderBottomViewBlock)block
{
    _block = block;
}

- (void)orderClick:(UIButton *)btn
{
    if (_block) {
        _block(btn.titleLabel.text);
    }
    
}

@end
