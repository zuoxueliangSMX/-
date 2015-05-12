//
//  WECartHomeCell.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/28.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECartHomeCell.h"
#import "WECartHomeCellBackgroudView.h"
@interface WECartHomeCell()
@property (nonatomic ,weak)WECartHomeCellBackgroudView *bgView;
@end
@implementation WECartHomeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _wbgv =[[WECartHomeCellBackgroudView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        [self.contentView addSubview:_wbgv];
    }
    
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
