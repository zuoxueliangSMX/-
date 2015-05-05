//
//  WEHotRecommendModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface WEHotRecommendModel : BaseModel
@property (nonatomic ,assign)NSInteger message;
@property (nonatomic ,strong)NSMutableArray *infos;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
