//
//  WEOrderDetailM.h
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/19.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface WEOrderDetailM : BaseModel
@property (nonatomic ,copy)NSString *address;
@property (nonatomic ,copy)NSString *gongji;
@property (nonatomic ,copy)NSString *message;
@property (nonatomic ,copy)NSString *mobile;
@property (nonatomic ,copy)NSString *order_num;
@property (nonatomic ,copy)NSString *order_person_name;


@property (nonatomic ,copy)NSString *order_state;
@property (nonatomic ,copy)NSString *order_time;
@property (nonatomic ,copy)NSString *phone;


@property (nonatomic ,copy)NSString *reduce_yunfei;
@property (nonatomic ,copy)NSString *yunfei;




@property (nonatomic ,copy)NSString *product_all_money;
@property (nonatomic ,strong)NSMutableArray *products;

- (instancetype)initWithDict:(NSDictionary *)dict;@end
