//
//  WEProductDetailVC.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEProductDetailModel.h"
@interface WEProductDetailVC : UIViewController
@property (nonatomic ,copy)NSString * productId;
@property (nonatomic ,strong)WEProductDetailModel *detailModel;
@end
