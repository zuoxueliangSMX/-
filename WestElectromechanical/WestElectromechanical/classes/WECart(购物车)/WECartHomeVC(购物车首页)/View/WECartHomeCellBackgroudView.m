//
//  WEHomeCellBackgroudView.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/28.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECartHomeCellBackgroudView.h"
#import "WECartHomeCellMiddleInfoView.h"
#import "WECartHomeCellBottomView.h"
#define kCellMargin 3
@interface WECartHomeCellBackgroudView()
@end
@implementation WECartHomeCellBackgroudView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *deleteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame =CGRectMake(SCREEN_WIDTH - 60, kCellMargin, 50, 20);
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = font(16);
        [deleteBtn setBackgroundColor:[UIColor clearColor]];
        [deleteBtn addTarget:self action:@selector(deleteCartInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        
        UIView *line1 =[[UIView alloc]initWithFrame:CGRectMake(kCellMargin, CGRectGetMaxY(deleteBtn.frame)+kCellMargin, SCREEN_WIDTH-2*kCellMargin-1, 1)];
        line1.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:line1];
        
        WECartHomeCellMiddleInfoView *middleView =
        [[WECartHomeCellMiddleInfoView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line1.frame)+2, SCREEN_WIDTH, 110)];
        [self addSubview:middleView];
        
        UIView *line2 =[[UIView alloc]initWithFrame:CGRectMake(kCellMargin, CGRectGetMaxY(middleView.frame)+kCellMargin, SCREEN_WIDTH-2*kCellMargin-1, 1)];
        line2.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:line2];
        
        WECartHomeCellBottomView *bottomView =[[WECartHomeCellBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line2.frame)+kCellMargin, SCREEN_WIDTH, 35)];
        bottomView.backgroundColor =[UIColor redColor];
        [self addSubview:bottomView];
    }
    return self;
}
- (void)deleteCartInfo:(UIButton *)btn
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
