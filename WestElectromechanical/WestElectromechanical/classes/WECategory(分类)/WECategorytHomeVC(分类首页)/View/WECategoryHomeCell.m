//
//  WECategoryHomeCell.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/28.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECategoryHomeCell.h"
#define kCellMargin 15
#define kCellVerMargin 5
#define kCellVHorMargin 10
#define kCellImageWidth 50.0/2.0
#define kCellImageHeight 55.0/2.0
@interface WECategoryHomeCell()

@end
@implementation WECategoryHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *cateImg = [[UIImageView alloc] initWithFrame:CGRectMake(kCellMargin, kCellMargin, kCellImageWidth, kCellImageHeight)];
        cateImg.backgroundColor =[UIColor clearColor];
        cateImg.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:cateImg];
        _cateImg = cateImg;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cateImg.frame)+kCellVHorMargin, kCellMargin, SCREEN_WIDTH-CGRectGetMaxX(_cateImg.frame)-2*kCellMargin, 18)];
        [titleLabel setFont:font(17)];
        [titleLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cateImg.frame)+kCellVHorMargin, CGRectGetMaxY(_titleLabel.frame)+kCellVerMargin, SCREEN_WIDTH-2*kCellMargin, 14)];
        [contentLabel setFont:font(12)];
        [contentLabel setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:contentLabel];
        _contentLabel = contentLabel;
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
