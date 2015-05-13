//
//  WECartHomeCellMiddleInfoView.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/28.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECartHomeCellMiddleInfoView.h"
@interface WECartHomeCellMiddleInfoView()
/**
 *  选择btn
 */

@end
@implementation WECartHomeCellMiddleInfoView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _chooseBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _chooseBtn.frame =CGRectMake(0, frame.size.height*0.5-5, 0, 20);
        [_chooseBtn setImage:[UIImage imageNamed:@"appleDot"] forState:UIControlStateNormal];
        [_chooseBtn setImage:[UIImage imageNamed:@"currentAppleDot"] forState:UIControlStateSelected];
        [_chooseBtn setBackgroundColor:[UIColor clearColor]];
        [_chooseBtn addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_chooseBtn];
        
        
        
        
            _moveView =  [[UIView alloc]init];
             _moveView .frame =CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
            [self addSubview:_moveView ];
        _productImg =[[UIImageView alloc]init];
        _productImg.frame =CGRectMake(10,frame.size.height * 0.5-50,80, 80);
        [_productImg setImage:[UIImage imageNamed:@"Product_Placeholder"]];
        [_moveView addSubview:_productImg];
        
        
        _productLabel =[[UILabel alloc]init];
        _productLabel.frame =CGRectMake(CGRectGetMaxX(_productImg.frame)+10,CGRectGetMinY(_productImg.frame),SCREEN_WIDTH-CGRectGetMaxX(_productLabel.frame)-10-20,20);
        _productLabel.numberOfLines =1;
        _productLabel.font =[UIFont systemFontOfSize:12.0];
        _productLabel.textColor =[UIColor darkGrayColor];
        _productLabel.backgroundColor =[UIColor clearColor];
        [_moveView addSubview:_productLabel];
        
        
        _productCartIdLabel =[[UILabel alloc]init];
        _productCartIdLabel.frame =CGRectMake(CGRectGetMaxX(_productImg.frame)+10,CGRectGetMaxY(_productLabel.frame),SCREEN_WIDTH-CGRectGetMaxX(_productImg.frame)-10-20,30);
        _productCartIdLabel.numberOfLines =2;
        _productCartIdLabel.font =[UIFont systemFontOfSize:12.0];
        _productCartIdLabel.textColor =[UIColor lightGrayColor];
        _productCartIdLabel.backgroundColor =[UIColor clearColor];
        [_moveView addSubview:_productCartIdLabel];
        
        
        _versionBrandLa =[[UILabel alloc]init];
        _versionBrandLa.frame =CGRectMake(CGRectGetMaxX(_productImg.frame)+10,CGRectGetMaxY(_productCartIdLabel.frame)+3,SCREEN_WIDTH-CGRectGetMinX(_productCartIdLabel.frame)-10-20,20);
        _versionBrandLa.numberOfLines =1;
        _versionBrandLa.font =[UIFont systemFontOfSize:12.0];
        _versionBrandLa.text =@"hdjkslkadsldkl";
        _versionBrandLa.textColor =[UIColor lightGrayColor];
        _versionBrandLa.backgroundColor =[UIColor clearColor];
        [_moveView addSubview:_versionBrandLa];
        
        
        _priceLabel =[[UILabel alloc]init];
        _priceLabel.frame =CGRectMake(CGRectGetMaxX(_productImg.frame)+10,CGRectGetMaxY(_versionBrandLa.frame)+3,SCREEN_WIDTH-CGRectGetMinX(_productCartIdLabel.frame)-10-20,20);
        _priceLabel.numberOfLines =1;
        _priceLabel.font =[UIFont systemFontOfSize:12.0];
        _priceLabel.textColor =[UIColor redColor];
        _priceLabel.backgroundColor =[UIColor clearColor];
        [_moveView addSubview:_priceLabel];
    }
    return self;
}


- (void)chooseClick:(UIButton *)btn{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
