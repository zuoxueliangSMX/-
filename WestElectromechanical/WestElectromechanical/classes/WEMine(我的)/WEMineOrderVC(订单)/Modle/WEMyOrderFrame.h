//
//  WEMyOrderFrame.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"
#import "OrderM.h"
@interface WEMyOrderFrame : BaseModel
@property (nonatomic ,strong)OrderM *orderModel;
@property (nonatomic ,assign)CGRect headerFrame;
@property (nonatomic ,assign)CGRect middleFrame;
@property (nonatomic ,assign)CGRect bottomFrame;
@property (nonatomic ,assign)CGFloat height;
@end
