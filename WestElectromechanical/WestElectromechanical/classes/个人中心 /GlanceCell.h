//
//  GlanceCell.h
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlanceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLa;
@property (weak, nonatomic) IBOutlet UILabel *orderNum;

@property (weak, nonatomic) IBOutlet UILabel *styleBrand;

@property (weak, nonatomic) IBOutlet UILabel *priceLa;

@property (weak, nonatomic) IBOutlet UILabel *memberPrice;

@property (weak, nonatomic) IBOutlet UIButton *cartBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end
