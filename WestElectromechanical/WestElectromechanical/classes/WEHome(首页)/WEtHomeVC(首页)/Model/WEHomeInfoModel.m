//
//  WEHomeInfoModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEHomeInfoModel.h"

@implementation WEHomeInfoModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.message =[[dict objectForKey:@"message"] integerValue];
        self.ads =[NSMutableArray array];
        for (NSDictionary *ad in [dict objectForKey:@"ads"]) {
            WEAdModel *adModel =[[WEAdModel alloc]initWithDict:ad];
            [self.ads addObject:adModel];
        }
        self.nocices =[NSMutableArray array];
        for (NSDictionary *nocice in [dict objectForKey:@"nocices"]) {
            WENoticeModel *nociceModel =[[WENoticeModel alloc]initWithDict:nocice];
            [self.nocices addObject:nociceModel];
        }
        self.recommends =[NSMutableArray array];
        for (NSDictionary *recommend in [dict objectForKey:@"recommends"]) {
            WERecommendModel *recommendModel =[[WERecommendModel alloc]initWithDict:recommend];
            [self.recommends addObject:recommendModel];
        }
    }
    return self;
}
@end
