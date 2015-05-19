//
//  WEOrderDetailM.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/19.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEOrderDetailM.h"
#import "ProductsM.h"

@implementation WEOrderDetailM
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.address =[self stringFromValue:[dict objectForKey:@"address"]];
        self.gongji =[self stringFromValue:[dict objectForKey:@"gongji"]];
        self.message =[self stringFromValue:[dict objectForKey:@"message"]];
        self.mobile =[self stringFromValue:[dict objectForKey:@"mobile"]];
        self.order_num =[self stringFromValue:[dict objectForKey:@"order_num"]];
        self.order_person_name =[self stringFromValue:[dict objectForKey:@"order_person_name"]];
        self.order_state =[self stringFromValue:[dict objectForKey:@"order_state"]];
        self.order_time =[self stringFromValue:[dict objectForKey:@"order_time"]];
        self.phone =[self stringFromValue:[dict objectForKey:@"phone"]];
        self.product_all_money =[self stringFromValue:[dict objectForKey:@"product_all_money"]];
        self.products =[NSMutableArray arrayWithCapacity:0];
       
        self.reduce_yunfei =[self stringFromValue:[dict objectForKey:@"reduce_yunfei"]];
        self.yunfei =[self stringFromValue:[dict objectForKey:@"yunfei"]];
        
        
        for (NSDictionary *products in [dict objectForKey:@"products"]) {
            ProductsM *pm =[[ProductsM alloc]initWithDict:products];
            [self.products addObject:pm];
        }
    }
    return self;
}

@end
