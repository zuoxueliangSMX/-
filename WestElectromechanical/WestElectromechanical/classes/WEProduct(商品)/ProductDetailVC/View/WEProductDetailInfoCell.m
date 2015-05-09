//
//  WEProductDetailInfoCell.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/8.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductDetailInfoCell.h"
@interface WEProductDetailInfoCell()
@end
@implementation WEProductDetailInfoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        WEProductInfoView *infoView =[[WEProductInfoView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.contentView addSubview:infoView];
        _infoView = infoView;
    }
    
    return self;
}

- (void)setDetailModel:(WEProductDetailModel *)detailModel
{
    _detailModel = detailModel;
    _infoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [WEProductInfoView sizeWithDetailModel:detailModel].height);
    _infoView.detailModel = detailModel;

    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
