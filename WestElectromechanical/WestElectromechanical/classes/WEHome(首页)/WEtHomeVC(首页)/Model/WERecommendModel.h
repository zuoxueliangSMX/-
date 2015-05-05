//
//  WERecommendModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface WERecommendModel : BaseModel
@property (nonatomic ,copy)NSString *contentid;
@property (nonatomic ,copy)NSString *Imgurl;
@property (nonatomic ,copy)NSString *p_id;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
