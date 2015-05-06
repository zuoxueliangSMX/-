//
//  WECategorySingleModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECategorySingleModel.h"

@implementation WECategorySingleModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.t_id = [self stringFromValue:[dict objectForKey:@"t_id"]];
        self.t_name= [self stringFromValue:[dict objectForKey:@"t_name"]];
        self.t_imgurl= [self stringFromValue:[dict objectForKey:@"t_imgurl"]];
        self.t_types= [self stringFromValue:[dict objectForKey:@"t_types"]];
    }
    return self;
}
@end
