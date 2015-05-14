//
//  WEProductPicsModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/14.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductPicsModel.h"

@implementation WEProductPicsModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.Imgurl =[self stringFromValue:[dict objectForKey:@"Imgurl"]];
    }
    return self;
}

@end
