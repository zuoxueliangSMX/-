//
//  WEAdModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEAdModel.h"

@implementation WEAdModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.pic =[NSString stringWithFormat:@"%@%@",kWEImgUrl,[self stringFromValue:[dict objectForKey:@"pic"]]];
        self.pid =[NSString stringWithFormat:@"%@",[self stringFromValue:[dict objectForKey:@"p_id"]]];
    }
    return self;
}
@end
