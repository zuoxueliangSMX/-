//
//  WEProductsModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/9.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface WEProductsModel : BaseModel
@property (nonatomic ,copy)NSString *message;
@property (nonatomic ,copy)NSString *page;
@property (nonatomic ,copy)NSString *pagej;
@property (nonatomic ,strong)NSMutableArray *products;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
