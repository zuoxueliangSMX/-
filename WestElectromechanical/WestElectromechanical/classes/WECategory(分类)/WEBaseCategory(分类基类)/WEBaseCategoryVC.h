//
//  WEBaseCategoryVC.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/9.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WECategorysModel.h"
@interface WEBaseCategoryVC : UIViewController
@property (nonatomic ,strong)WECategorysModel *leftModel;
@property (nonatomic ,strong)WECategorysModel *rightModel;
@property (nonatomic ,strong)NSIndexPath *selectedIndex;
@property (nonatomic ,assign)NSInteger selectedRow;
@property (nonatomic ,strong)NSMutableArray *leftArr;
@property (nonatomic ,strong)NSMutableArray *rightArr;
@property (nonatomic ,weak)UITableView *leftTable;
@property (nonatomic ,weak)UITableView *rightTable;
@end
