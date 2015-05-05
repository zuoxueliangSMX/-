//
//  WEHotRecommendSingleModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEHotRecommendSingleModel.h"

@implementation WEHotRecommendSingleModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
 
        self.name =[self stringFromValue:[dict objectForKey:@"name"]];
    }
    return self;
}
@end
