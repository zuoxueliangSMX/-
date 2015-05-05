//
//  WENoticeModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WENoticeModel.h"

@implementation WENoticeModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.n_id =[self stringFromValue:[dict objectForKey:@"n_id"]];
        self.n_name =[self stringFromValue:[dict objectForKey:@"n_name"]];
    }
    return self;
}
@end
