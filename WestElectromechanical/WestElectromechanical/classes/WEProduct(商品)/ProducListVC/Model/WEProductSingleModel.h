//
//  WEProductSingleModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/9.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface WEProductSingleModel : BaseModel
@property (nonatomic ,copy)NSString *p_brand;
@property (nonatomic ,copy)NSString *p_imgurl;
@property (nonatomic ,copy)NSString *p_name;
@property (nonatomic ,copy)NSString *p_order_num;
@property (nonatomic ,copy)NSString *p_price;
@property (nonatomic ,copy)NSString *p_v_price;
@property (nonatomic ,copy)NSString *p_version;
@property (nonatomic ,copy)NSString *pid;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
