//
//  WEAdvertModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEAdvertModel.h"

@implementation WEAdvertModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.catid =[self stringFromValue:[dict objectForKey:@"catid"]];
        self.pic =[self stringFromValue:[dict objectForKey:@"pic"]];
    }
    return self;
}
@end
