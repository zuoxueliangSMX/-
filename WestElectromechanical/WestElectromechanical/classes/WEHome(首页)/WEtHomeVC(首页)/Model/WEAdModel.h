//
//  WEAdModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface WEAdModel : BaseModel
@property (nonatomic ,copy)NSString * pic;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
