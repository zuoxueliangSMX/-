//
//  GlanceCell.h
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlanceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLa;
@property (weak, nonatomic) IBOutlet UILabel *orderNum;

@property (weak, nonatomic) IBOutlet UILabel *styleBrand;

@property (weak, nonatomic) IBOutlet UILabel *priceLa;

@property (weak, nonatomic) IBOutlet UILabel *memberPrice;

@property (weak, nonatomic) IBOutlet UIButton *cartBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;



//我的订单里面属性

//订单号
@property (weak, nonatomic) IBOutlet UILabel *orderCodeLa;
//订单时间
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLa;
//会变换名称的label   待付款 待收货等等
@property (weak, nonatomic) IBOutlet UILabel *changgeLa;
//总价
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLa;
//会变换名称的label   立即支付 确认收货等等
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;



//我的订单详情:
//headview

@property (weak, nonatomic) IBOutlet UILabel *CompletedLa;
@property (weak, nonatomic) IBOutlet UILabel *WaitComentLa;

@property (weak, nonatomic) IBOutlet UILabel *NameAndPhoneLa;
@property (weak, nonatomic) IBOutlet UILabel *addressLa;
//footview
@property (weak, nonatomic) IBOutlet UILabel *totalCountLa;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLa;
@property (weak, nonatomic) IBOutlet UILabel *freightageLa;
@property (weak, nonatomic) IBOutlet UILabel *subtractFeeLa;
@property (weak, nonatomic) IBOutlet UILabel *goodsTotalPriceLa;

@end
