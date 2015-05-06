//
//  WECategorySingleModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface WECategorySingleModel : BaseModel
@property (nonatomic ,copy)NSString * t_id;
@property (nonatomic ,copy)NSString * t_name;
@property (nonatomic ,copy)NSString * t_imgurl;
@property (nonatomic ,copy)NSString * t_types;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
