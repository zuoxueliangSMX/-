//
//  WEMineOrderMiddleView.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderM.h"
@interface WEMineOrderMiddleView : UIView
/**
 *  图片数据（里面都是Photo模型）
 */
@property (nonatomic ,strong)NSMutableArray *subViewArr;
@property (nonatomic ,strong)OrderM *orderModel;

@end
