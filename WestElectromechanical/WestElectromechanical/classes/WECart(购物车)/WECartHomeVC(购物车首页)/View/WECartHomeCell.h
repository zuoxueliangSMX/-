//
//  WECartHomeCell.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/28.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WECartHomeCellBackgroudView.h"
@interface WECartHomeCell : UITableViewCell
@property (nonatomic ,strong)MyCartM *myCartModel;
@property (nonatomic ,weak)WECartHomeCellBackgroudView *bgView;

@end
