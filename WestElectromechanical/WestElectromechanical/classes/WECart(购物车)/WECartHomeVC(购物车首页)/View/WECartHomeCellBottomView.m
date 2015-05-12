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
        
        UILabel *shuliangLa  = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 30)];
        shuliangLa.text =@"数量:";
        shuliangLa.font = [UIFont systemFontOfSize:14];
        [self addSubview:shuliangLa];
        
_leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shuliangLa.frame)+10, 0, 30, 30)];
//    [leftBtn setBackgroundImage:[UIImage imageNamed:@"ordermin"] forState:UIControlStateNormal];
        _leftBtn.backgroundColor = [UIColor greenSeaColor];
    _leftBtn.tag = 7707;
    [self addSubview:_leftBtn];
    
    _numTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftBtn.frame), 0, 30, 30)];
    _numTF.backgroundColor = SET_COLOR(237.f, 237.f, 237.f);
    _numTF.layer.borderWidth = 1;
    _numTF.layer.borderColor = SET_COLOR(168.f, 174.f, 178.f).CGColor;
    _numTF.text = @"1";
    
    _numTF.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numTF];
    
    _rigBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_numTF.frame), 0, 30, 30)];
    _rigBtn.tag = 7708;
        _rigBtn.backgroundColor = [UIColor greenSeaColor];

//    [rigBtn setBackgroundImage:[UIImage imageNamed:@"orderplus"] forState:UIControlStateNormal];
    [self addSubview:_rigBtn];
        
        _jineLa  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_rigBtn.frame)+20, 0, 100, 30)];

        _jineLa.textColor = [UIColor orangeColor];
        _jineLa.font = [UIFont systemFontOfSize:14];
        [self addSubview:_jineLa];
   
        
}


    return self;
}

@end
