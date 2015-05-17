//
//  OrderM.h
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/17.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface OrderM : BaseModel
@property (nonatomic ,copy)NSString *all_money;
@property (nonatomic ,copy)NSString *o_id;
@property (nonatomic ,copy)NSString *order_num;
@property (nonatomic ,copy)NSMutableArray *order_products;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
