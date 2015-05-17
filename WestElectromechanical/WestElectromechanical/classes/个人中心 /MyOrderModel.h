//
//  MyOrderModel.h
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/17.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface MyOrderModel : BaseModel
@property (nonatomic ,copy)NSString *message;
@property (nonatomic ,copy)NSString *page;
@property (nonatomic ,copy)NSString *pagej;
@property (nonatomic ,strong)NSMutableArray *orders;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
