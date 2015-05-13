//
//  WEProductInfoView.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/8.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEProductDetailModel.h"
@interface WEProductInfoView : UIView
@property (nonatomic ,assign)CGFloat height;
@property (nonatomic ,strong)WEProductDetailModel *detailModel;
+ (CGSize)sizeWithDetailModel:(WEProductDetailModel *)model;
@end
