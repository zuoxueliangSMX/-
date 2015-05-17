//
//  WEMineOrderCell.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEMineOrderCell.h"
@interface WEMineOrderCell()
@property (nonatomic ,weak)UIView *bgView;
@end
@implementation WEMineOrderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        bgView.backgroundColor =[UIColor whiteColor];
        [self.contentView addSubview:bgView];
        _bgView = bgView;
        
        WEMineOrderHeaderView *headerView =[[WEMineOrderHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        [self.contentView addSubview:headerView];
        _headerView = headerView;

        
        WEMineOrderBottomView *bottomView =[[WEMineOrderBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), SCREEN_WIDTH, 50)];
        [self.contentView addSubview:bottomView];
        _bottomView = bottomView;
    }
    
    return self;
}

- (void)setOrderFrame:(WEMyOrderFrame *)orderFrame
{
    _orderFrame = orderFrame;
    _headerView.frame = orderFrame.headerFrame;

    [_middleView removeFromSuperview];
    WEMineOrderMiddleView *middleView =[[WEMineOrderMiddleView alloc]initWithFrame:orderFrame.middleFrame];
    [self.contentView addSubview:middleView];
    _middleView = middleView;
    _bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, orderFrame.height);
    _bottomView.frame = orderFrame.bottomFrame;
    _headerView.orderModel = orderFrame.orderModel;
    _middleView.orderModel = orderFrame.orderModel;
    _bottomView.orderModel = orderFrame.orderModel;
    _middleView.subViewArr =_orderFrame.orderModel.order_products;
}
@end
