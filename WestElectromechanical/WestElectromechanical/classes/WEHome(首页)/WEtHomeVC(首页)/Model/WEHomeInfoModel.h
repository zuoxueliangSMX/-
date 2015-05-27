//
//  WEHomeInfoModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"
#import "WEAdModel.h"
#import "WENoticeModel.h"
#import "WERecommendModel.h"
#import "WEAdvertModel.h"
@interface WEHomeInfoModel : BaseModel
@property (nonatomic ,assign)NSInteger message;
@property (nonatomic ,strong)NSMutableArray *ads;
@property (nonatomic ,strong)NSMutableArray *nocices;
@property (nonatomic ,strong)NSMutableArray *recommends;
@property (nonatomic ,strong)NSMutableArray *advert;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
