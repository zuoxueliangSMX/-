//
//  WEHomeCellBackgroudView.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/28.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECartHomeCellBackgroudView.h"
#define kCellMargin 3
@interface WECartHomeCellBackgroudView()
@property (nonatomic ,weak)UIButton *deleteBtn;

@end
@implementation WECartHomeCellBackgroudView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton * deleteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame =CGRectMake(SCREEN_WIDTH - 60, kCellMargin, 50, 30);
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = font(16);
        [deleteBtn setBackgroundColor:[UIColor clearColor]];
        [deleteBtn addTarget:self action:@selector(deleteCartInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
        
        UIView *line1 =[[UIView alloc]initWithFrame:CGRectMake(kCellMargin, CGRectGetMaxY(deleteBtn.frame)+kCellMargin, SCREEN_WIDTH-2*kCellMargin-1, 1)];
        line1.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:line1];
        
        WECartHomeCellMiddleInfoView *middleview =
        [[WECartHomeCellMiddleInfoView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line1.frame)+2, SCREEN_WIDTH, 100)];
        [self addSubview:middleview];
        _middleview = middleview;
        
        UIView *line2 =[[UIView alloc]initWithFrame:CGRectMake(kCellMargin, CGRectGetMaxY(_middleview.frame)+kCellMargin, SCREEN_WIDTH-2*kCellMargin-1, 1)];
        line2.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:line2];
        
        WECartHomeCellBottomView *bottomView =[[WECartHomeCellBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line2.frame)+kCellMargin, SCREEN_WIDTH, 35)];
      
        [self addSubview:bottomView];
        _bottomView = bottomView;
    }
    return self;
}

- (void)setMyCartModel:(MyCartM *)myCartModel
{
    _myCartModel = myCartModel;
    _bottomView.myCartModel = myCartModel;
    _middleview.myCartModel = myCartModel;
}

- (void)setCartdeleteBlock:(cartHomeDeleteBtnBlock)deleteBtnBlock
{
    _deleteBtnBlock =deleteBtnBlock;

}

- (void)deleteCartInfo:(UIButton *)btn
{
    if (_deleteBtnBlock) {
        _deleteBtnBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
