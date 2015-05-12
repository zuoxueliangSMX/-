//
//  WECartHomeCellBottomView.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/2.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECartHomeCellBottomView.h"

@implementation WECartHomeCellBottomView
-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        UILabel *shuliangLa  = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 30)];
        shuliangLa.text =@"数量:";
        shuliangLa.font = [UIFont systemFontOfSize:14];
        [self addSubview:shuliangLa];
        
    _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shuliangLa.frame)+10, 0, 30, 30)];
//    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"cart_cut"] forState:UIControlStateNormal];
       
        [_leftBtn setTitle:@"-" forState:UIControlStateNormal];
          _leftBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
         [_leftBtn.layer  setBorderWidth:1.0];
         [_leftBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
       _leftBtn.tag = 7707;
    [self addSubview:_leftBtn];
    
    _numTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftBtn.frame), 0, 40, 30)];
    _numTF.layer.borderWidth = 1;
    _numTF.layer.borderColor = SET_COLOR(168.f, 174.f, 178.f).CGColor;
    _numTF.text = @"0";
    
    _numTF.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numTF];
    
    _rigBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_numTF.frame), 0, 30, 30)];
    _rigBtn.tag = 7708;
        [_rigBtn.layer  setBorderWidth:1.0];
        _rigBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
        [_rigBtn setTitle:@"+" forState:UIControlStateNormal];
        [_rigBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
         _rigBtn.titleLabel.textColor = [UIColor darkGrayColor];
//    [_rigBtn setBackgroundImage:[UIImage imageNamed:@"cart_plus"] forState:UIControlStateNormal];
    [self addSubview:_rigBtn];
        
    _jineLa  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_rigBtn.frame)+20, 0, 100, 30)];

    _jineLa.textColor = [UIColor orangeColor];
    _jineLa.font = [UIFont systemFontOfSize:14];
        _jineLa.text =@"金额：0";
    [self addSubview:_jineLa];
    [ _leftBtn addTarget:self action:@selector(cutClick) forControlEvents:UIControlEventTouchUpInside];
    [_rigBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
}


    return self;
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
