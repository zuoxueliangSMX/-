//
//  ProductsM.h
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/17.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"
#import <Foundation/Foundation.h>

@interface ProductsM : BaseModel
@property(nonatomic,copy)NSString *p_brand;
@property(nonatomic,copy)NSString *p_id;
@property(nonatomic,copy)NSString *p_imgurl;
@property(nonatomic,copy)NSString *p_order_num;
@property(nonatomic,copy)NSString *p_price;
@property(nonatomic,copy)NSString *p_version;
@property(nonatomic,copy)NSString *p_name;
@property(nonatomic,copy)NSString *p_num;
//@property (nonatomic ,assign)BOOL isDeleteNoOrYes;
//@property (nonatomic ,assign)BOOL isChoose;//是否被选中
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
