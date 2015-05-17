//
//  WEMineOrderCell.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEMineOrderBottomView.h"
#import "WEMineOrderHeaderView.h"
#import "WEMineOrderMiddleView.h"
#import "WEMyOrderFrame.h"
@interface WEMineOrderCell : UITableViewCell
@property (nonatomic ,weak)WEMineOrderBottomView *bottomView;
@property (nonatomic ,weak)WEMineOrderHeaderView *headerView;
@property (nonatomic ,weak)WEMineOrderMiddleView *middleView;
@property (nonatomic ,strong)WEMyOrderFrame *orderFrame;
@end
