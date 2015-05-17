    //
//  OrderM.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/17.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "OrderM.h"
#import "ProductsM.h"


@implementation OrderM
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.all_money =[self stringFromValue:[dict objectForKey:@"all_money"]];
        self.o_id =[self stringFromValue:[dict objectForKey:@"o_id"]];
        self.order_num =[self stringFromValue:[dict objectForKey:@"order_num"]];
        self.order_state =[self stringFromValue:[dict objectForKey:@"order_state"]];
        self.order_time =[self stringFromValue:[dict objectForKey:@"order_time"]];
        self.order_products =[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *products in [dict objectForKey:@"order_products"]) {
            ProductsM *pm =[[ProductsM alloc]initWithDict:products];
            [self.order_products addObject:pm];
        }
    }
    return self;
}

@end
