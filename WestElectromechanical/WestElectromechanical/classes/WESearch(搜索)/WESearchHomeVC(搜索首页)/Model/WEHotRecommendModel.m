//
//  WEHotRecommendModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEHotRecommendModel.h"
#import "WEHotRecommendSingleModel.h"
@implementation WEHotRecommendModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.infos =[NSMutableArray array];
        self.message =[[dict objectForKey:@"message"] integerValue];
        for (NSDictionary *info in [dict objectForKey:@"infos"]) {
            WEHotRecommendSingleModel *model =[[WEHotRecommendSingleModel alloc]initWithDict:info];
            [self.infos addObject:model];
        }
    }
    return self;
}
@end
