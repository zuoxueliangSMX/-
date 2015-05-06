//
//  WECategorysModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECategorysModel.h"
#import "WECategorySingleModel.h"
@implementation WECategorysModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
 
        self.message =[[dict objectForKey:@"message"] integerValue];
        self.types =[NSMutableArray array];
        for (NSDictionary *category in [dict objectForKey:@"types"]) {
            WECategorySingleModel *model =[[WECategorySingleModel alloc]initWithDict:category];
            [self.types addObject:model];
        }
    }
    return self;
}
@end
