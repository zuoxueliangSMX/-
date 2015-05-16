//
//  WECartHomeCell.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/28.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECartHomeCell.h"
@interface WECartHomeCell()
@end
@implementation WECartHomeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        WECartHomeCellBackgroudView * wbgv =[[WECartHomeCellBackgroudView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        wbgv.backgroundColor =[UIColor whiteColor];
        [self.contentView addSubview:wbgv];
        _bgView = wbgv;
    }
    
    return self;
}

- (void)setMyCartModel:(MyCartM *)myCartModel
{
    _myCartModel = myCartModel;
    _bgView.myCartModel = myCartModel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
