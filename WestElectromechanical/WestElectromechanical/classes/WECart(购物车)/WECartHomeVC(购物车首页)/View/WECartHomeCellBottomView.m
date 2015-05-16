//
//  WECartHomeCellBottomView.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/2.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECartHomeCellBottomView.h"
@interface WECartHomeCellBottomView()
@property(nonatomic,weak)UIButton *rigBtn;
@property(nonatomic,weak)UIButton *leftBtn;
@property(nonatomic,weak)UILabel  *numTF;
@property(nonatomic,weak)UILabel *jineLa;
@end
@implementation WECartHomeCellBottomView
-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        UILabel *shuliangLa  = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 30)];
        shuliangLa.text =@"数量:";
        shuliangLa.font = [UIFont systemFontOfSize:14];
        [self addSubview:shuliangLa];
        
     
        UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shuliangLa.frame)+10, 0, 30, 30)];
        [leftBtn setTitle:@"-" forState:UIControlStateNormal];
          leftBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
         [leftBtn.layer  setBorderWidth:1.0];
         [leftBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        leftBtn.tag = 7707;
        [self addSubview:leftBtn];
        _leftBtn = leftBtn;
    
   
        UILabel *numTF = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftBtn.frame), 0, 40, 30)];
        numTF.layer.borderWidth = 1;
        numTF.layer.borderColor = SET_COLOR(168.f, 174.f, 178.f).CGColor;
        numTF.text = @"1";
        numTF.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numTF];
        _numTF = numTF;
    
    
        UIButton * rigBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_numTF.frame), 0, 30, 30)];
        rigBtn.tag = 7708;
   
        [rigBtn.layer  setBorderWidth:1.0];
        rigBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
        [rigBtn setTitle:@"+" forState:UIControlStateNormal];
        [rigBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
         rigBtn.titleLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:rigBtn];
        _rigBtn = rigBtn;
        
        UILabel * jineLa = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_rigBtn.frame)+20, 0, 100, 30)];
        jineLa.textColor = [UIColor orangeColor];
        jineLa.font = [UIFont systemFontOfSize:14];
        jineLa.text =@"金额：";
        [self addSubview:jineLa];
        _jineLa = jineLa;
        
        [ _leftBtn addTarget:self action:@selector(cutClick) forControlEvents:UIControlEventTouchUpInside];
        [_rigBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
}


    return self;
}

- (void)setMyCartModel:(MyCartM *)myCartModel
{
    _myCartModel = myCartModel;
    
    _jineLa.text =[NSString stringWithFormat:@"金额:%0.2f ",[myCartModel.p_num floatValue]*[myCartModel.p_price  floatValue]];
    _numTF.text =[NSString stringWithFormat:@"%ld",[myCartModel.p_num integerValue]];
}

- (void)setCartHomeCellBottomCutBlock:(cartHomeCellBottomCutBlock)block
{
    _cutBlock = block;
}
- (void)setCartHomeCellBottomPlusBlock:(cartHomeCellBottomPlusBlock)block
{
    _plusBlock = block;
}
- (void)plusClick
{
    if (_plusBlock) {
        _plusBlock([_numTF.text integerValue],_numTF,_jineLa);
    }
}
- (void)cutClick
{
    if (_cutBlock) {
        _cutBlock([_numTF.text integerValue],_numTF,_jineLa);
    }
}

@end
