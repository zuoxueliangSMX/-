//
//  WEProductDetailInfoCell.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/8.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEProductDetailModel.h"
#import "WEProductInfoView.h"
@interface WEProductDetailInfoCell : UITableViewCell
@property (nonatomic ,strong)WEProductDetailModel *detailModel;
@property (nonatomic ,weak)WEProductInfoView *infoView;
@end
