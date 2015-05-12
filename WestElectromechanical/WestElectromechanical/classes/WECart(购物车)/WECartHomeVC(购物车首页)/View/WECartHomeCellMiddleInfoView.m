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
@property (nonatomic ,weak)UIButton *chooseBtn;
@end
@implementation WECartHomeCellMiddleInfoView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *chooseBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        chooseBtn.frame =CGRectMake(10, frame.size.height*0.5-5, 20, 20);
        [chooseBtn setImage:[UIImage imageNamed:@"appleDot"] forState:UIControlStateNormal];
        [chooseBtn setImage:[UIImage imageNamed:@"currentAppleDot"] forState:UIControlStateSelected];
        [chooseBtn setBackgroundColor:[UIColor clearColor]];
        [chooseBtn addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:chooseBtn];
        
        
        UIImageView *productImg =[[UIImageView alloc]init];
        productImg.frame =CGRectMake(CGRectGetMaxX(chooseBtn.frame)+10,frame.size.height * 0.5-40,80, 80);
        [productImg setImage:[UIImage imageNamed:@"Product_Placeholder"]];
        [self addSubview:productImg];
        
        
        UILabel *productLabel =[[UILabel alloc]init];
        productLabel.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+10,CGRectGetMinY(productImg.frame),SCREEN_WIDTH-CGRectGetMaxX(productImg.frame)-10-20,20);
        productLabel.numberOfLines =1;
        productLabel.font =[UIFont systemFontOfSize:18.0];
        productLabel.text =@"hdjkslkadsldkl";
        productLabel.textColor =[UIColor blackColor];
        productLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:productLabel];
        
        
        UILabel *productCartIdLabel =[[UILabel alloc]init];
        productCartIdLabel.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+10,CGRectGetMaxY(productLabel.frame)+3,SCREEN_WIDTH-CGRectGetMaxX(productImg.frame)-10-20,20);
        productCartIdLabel.numberOfLines =1;
        productCartIdLabel.font =[UIFont systemFontOfSize:18.0];
        productCartIdLabel.text =@"hdjkslkadsldkl";
        productCartIdLabel.textColor =[UIColor blackColor];
        productCartIdLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:productCartIdLabel];
        
        
        UILabel *productTypeLabel =[[UILabel alloc]init];
        productTypeLabel.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+10,CGRectGetMaxY(productLabel.frame)+3,SCREEN_WIDTH-CGRectGetMinX(productCartIdLabel.frame)-10-20,20);
        productTypeLabel.numberOfLines =1;
        productTypeLabel.font =[UIFont systemFontOfSize:18.0];
        productTypeLabel.text =@"hdjkslkadsldkl";
        productTypeLabel.textColor =[UIColor blackColor];
        productTypeLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:productTypeLabel];
        
        
        UILabel *priceLabel =[[UILabel alloc]init];
        priceLabel.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+10,CGRectGetMaxY(productTypeLabel.frame)+3,SCREEN_WIDTH-CGRectGetMinX(productCartIdLabel.frame)-10-20,20);
        priceLabel.numberOfLines =1;
        priceLabel.font =[UIFont systemFontOfSize:18.0];
        priceLabel.text =@"￥ 800.00";
        priceLabel.textColor =[UIColor redColor];
        priceLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:priceLabel];
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
