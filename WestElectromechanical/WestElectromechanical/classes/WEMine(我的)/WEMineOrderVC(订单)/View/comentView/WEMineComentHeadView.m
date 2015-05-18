//
//  WEMineComentHeadView.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEMineComentHeadView.h"


@interface  WEMineComentHeadView()
@property(nonatomic,weak)UIImageView *productImg;
@property(nonatomic,weak)UILabel *productLabel;
@property(nonatomic,weak)UILabel *productCartIdLabel;
@property(nonatomic,weak)UILabel *versionBrandLa;
@property(nonatomic,weak)UILabel *priceLabel;
@end
@implementation WEMineComentHeadView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *productImg =[[UIImageView alloc]init];
        productImg.frame =CGRectMake(10,5,80, 60);
        [productImg setImage:[UIImage imageNamed:@"Product_Placeholder"]];
        [self addSubview:productImg];
        _productImg = productImg;
        
        UILabel *titleLabel =[[UILabel alloc]init];
        titleLabel.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+10,CGRectGetMinY(productImg.frame),SCREEN_WIDTH-CGRectGetMaxX(titleLabel.frame)-10-20,20);
        titleLabel.numberOfLines =1;
        titleLabel.font =[UIFont systemFontOfSize:12.0];
        titleLabel.text =@"银河";
        titleLabel.textColor =[UIColor darkGrayColor];
        titleLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:titleLabel];
        _productLabel = titleLabel;
        
        UILabel * orderNumLa =[[UILabel alloc]init];
        orderNumLa.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+10,CGRectGetMaxY(titleLabel.frame),SCREEN_WIDTH-CGRectGetMaxX(productImg.frame)-10-20,24);
        orderNumLa.numberOfLines =2;
        orderNumLa.font =[UIFont systemFontOfSize:12.0];
        orderNumLa.textColor =[UIColor darkGrayColor];
        orderNumLa.backgroundColor =[UIColor clearColor];
        [self addSubview:orderNumLa];
        orderNumLa.text =@"订单号码1238267";
        _productCartIdLabel = orderNumLa;
        
        

    }
    return self;
}


@end
