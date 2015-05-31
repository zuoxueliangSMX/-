//
//  WECartsModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/12.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface WECartsModel : BaseModel
@property (nonatomic ,copy)NSString *message;
@property (nonatomic ,copy)NSString *page;
@property (nonatomic ,copy)NSString *pagej;
@property (nonatomic ,strong)NSMutableArray *products;
@property (nonatomic ,copy)NSString * productCounts;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
