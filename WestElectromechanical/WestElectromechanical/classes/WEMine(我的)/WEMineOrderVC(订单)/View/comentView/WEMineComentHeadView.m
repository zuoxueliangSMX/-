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
        
        _titleLabel =[[UILabel alloc]init];
        _titleLabel.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+10,CGRectGetMinY(productImg.frame),SCREEN_WIDTH-CGRectGetMaxX(_titleLabel.frame)-10-20,20);
        _titleLabel.numberOfLines =1;
        _titleLabel.font =[UIFont systemFontOfSize:12.0];
        _titleLabel.textColor =[UIColor darkGrayColor];
        _titleLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:_titleLabel];
        _productLabel = _titleLabel;
        
        _orderNumLa =[[UILabel alloc]init];
        _orderNumLa.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+10,CGRectGetMaxY(_titleLabel.frame),SCREEN_WIDTH-CGRectGetMaxX(productImg.frame)-10-20,24);
        _orderNumLa.numberOfLines =2;
        _orderNumLa.font =[UIFont systemFontOfSize:12.0];
        _orderNumLa.textColor =[UIColor darkGrayColor];
        [self addSubview:_orderNumLa];
        _productCartIdLabel = _orderNumLa;
        
        
        
        _titleLabel.text =self.pm.p_name;
        
        _orderNumLa.text =self.pm.p_order_num;

    }
    return self;
}

-(void)setPm:(ProductsM *)pm
{
    
    _pm=pm;
    
}
@end
