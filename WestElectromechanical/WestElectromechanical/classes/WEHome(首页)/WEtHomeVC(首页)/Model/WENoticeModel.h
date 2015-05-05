//
//  WENoticeModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface WENoticeModel : BaseModel
@property (nonatomic ,copy)NSString * n_id;
@property (nonatomic ,copy)NSString * n_name;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
