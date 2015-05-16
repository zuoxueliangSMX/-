//
//  WECartBottomView.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/16.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECartBottomView.h"
#import "UIButton+Extension.h"
@interface WECartBottomView()


@end
@implementation WECartBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *ALLBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        ALLBtn.frame =CGRectMake(10, 15, 20, 20);
        [ALLBtn setImage:[UIImage imageNamed:@"cart_notChose"] forState:UIControlStateNormal];
        [ALLBtn setImage:[UIImage imageNamed:@"cart_choseed"] forState:UIControlStateSelected];
        [ALLBtn setBackgroundColor:[UIColor clearColor]];
        [ALLBtn addTarget:self action:@selector(ALLchooseClic:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ALLBtn];
        _allButton = ALLBtn;
        
        UILabel *allLa=  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(ALLBtn.frame), 15, 30, 20)];
        allLa.font = [UIFont systemFontOfSize:14];
        allLa.text = @"全选";
        allLa.textColor  =[UIColor  darkGrayColor];
        [self addSubview:allLa];
        
        
        UILabel *totalCountLa=  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(allLa.frame)+10, 5, SCREEN_WIDTH- CGRectGetMaxX(allLa.frame)-10-90, 17)];
        totalCountLa.font = [UIFont systemFontOfSize:14];
        totalCountLa.text = @"总计";
        totalCountLa.textColor  =[UIColor  lightGrayColor];
        [self addSubview:totalCountLa];
        _totalCountLa = totalCountLa;
        
        UILabel *allPriceLa=  [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(allLa.frame)+10, CGRectGetMaxY(allLa.frame)-4, SCREEN_WIDTH- CGRectGetMaxX(allLa.frame)-10-90, 17)];
        allPriceLa.font = [UIFont systemFontOfSize:14];
        allPriceLa.text = @"总金额";
        allPriceLa.textColor  =[UIColor  lightGrayColor];
        [self addSubview:allPriceLa];
        _allPriceLa = allPriceLa;
        
        
        UIButton *clearingBtn =[[UIButton alloc]initTarget:self WithTitle:@"去结算" withColor:[UIColor whiteColor] action:@selector(instantPayClick:)];
        clearingBtn.titleLabel.font = font(16);
        [clearingBtn  setBackgroundColor:[UIColor  redColor]];
        
        clearingBtn.frame = CGRectMake(SCREEN_WIDTH-clearingBtn.size.width, 3, 70, 44);
        [self addSubview:clearingBtn];

    }
    return self;
}


- (void)setCartBottomViewClearingBlock:(cartBottomViewClearingBlock)block
{
    _clearingBlcok = block;
}
- (void)setCartBottomViewAllChooseBlock:(cartBottomViewAllChooseBlock)block
{
    _allChooseBlcok = block;
}

- (void)instantPayClick:(UIButton *)btn
{
    if (_clearingBlcok) {
        _clearingBlcok();
    }
    
}
- (void)ALLchooseClic:(UIButton *)btn
{
    if (_allChooseBlcok) {
        _allChooseBlcok(btn.selected);

           }
    if (btn.selected == YES) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
        
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
