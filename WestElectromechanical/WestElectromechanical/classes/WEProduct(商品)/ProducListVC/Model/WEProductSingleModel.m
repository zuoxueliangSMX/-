//
//  WEProductSingleModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/9.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductSingleModel.h"

@implementation WEProductSingleModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.p_brand =[self stringFromValue:[dict objectForKey:@"p_brand"]];
        self.p_imgurl=[NSString stringWithFormat:@"%@%@",kWEImgUrl,[self stringFromValue:[dict objectForKey:@"p_imgurl"]]];
        self.p_name=[self stringFromValue:[dict objectForKey:@"p_name"]];
        self.p_order_num=[self stringFromValue:[dict objectForKey:@"p_order_num"]];
        self.p_price=[self stringFromValue:[dict objectForKey:@"p_price"]];
        self.p_v_price=[self stringFromValue:[dict objectForKey:@"p_v_price"]];
        self.p_version=[self stringFromValue:[dict objectForKey:@"p_version"]];
        self.pid=[self stringFromValue:[dict objectForKey:@"pid"]];

    }
    return self;
}
@end
