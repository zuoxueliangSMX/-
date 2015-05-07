//
//  WEProductTableCell.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WEProductTableCell : UITableViewCell
@property (nonatomic ,weak)UIImageView *productImg;
@property (nonatomic ,weak)UILabel *productTitle;
@property (nonatomic ,weak)UILabel *productOrder;
@property (nonatomic ,weak)UILabel *productType;
@property (nonatomic ,weak)UILabel *productBrand;
@property (nonatomic ,weak)UILabel *productPrice;
@property (nonatomic ,weak)UILabel *productSalePrice;
@property (nonatomic ,weak)UIButton *acrtBtn;
@end
