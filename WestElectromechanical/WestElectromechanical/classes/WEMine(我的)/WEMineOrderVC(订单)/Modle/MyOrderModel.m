//
//  MyOrderModel.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/17.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "MyOrderModel.h"
#import "OrderM.h"

@implementation MyOrderModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.message =[self stringFromValue:[dict objectForKey:@"message"]];
        self.page =[self stringFromValue:[dict objectForKey:@"page"]];
        self.pagej =[self stringFromValue:[dict objectForKey:@"pagej"]];
        self.orders =[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *order in [dict objectForKey:@"orders"]) {
            OrderM *om =[[OrderM alloc]initWithDict:order];
            WEMyOrderFrame *orderFrame = [[WEMyOrderFrame alloc]init];
            orderFrame.orderModel = om;
            [self.orders addObject:orderFrame];
        }
    }
    return self;
}

@end
