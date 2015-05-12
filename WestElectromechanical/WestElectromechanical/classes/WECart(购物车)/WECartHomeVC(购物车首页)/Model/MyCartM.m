//
//  MyCartM.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/12.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "MyCartM.h"

@implementation MyCartM
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.p_brand =[self stringFromValue:[dict objectForKey:@"p_brand"]];
        self.p_id=[self stringFromValue:[dict objectForKey:@"p_id"]];
        self.p_imgurl=[self stringFromValue:[dict objectForKey:@"p_imgurl"]];
        self.p_order_num=[self stringFromValue:[dict objectForKey:@"p_order_num"]];
        self.p_price=[self stringFromValue:[dict objectForKey:@"p_price"]];
        self.p_version=[self stringFromValue:[dict objectForKey:@"p_version"]];
        self.p_name=[self stringFromValue:[dict objectForKey:@"p_name"]];
        self.p_num=[self stringFromValue:[dict objectForKey:@"p_num"]];
    }
    return self;
}
@end
