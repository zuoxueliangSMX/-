//
//  WEAdvertModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface WEAdvertModel : BaseModel
@property (nonatomic ,copy)NSString * catid;
@property (nonatomic ,copy)NSString * pic;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
