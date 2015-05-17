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
        for (NSDictionary *orders in [dict objectForKey:@"orders"]) {
            OrderM *om =[[OrderM alloc]initWithDict:orders];
            [self.orders addObject:om];
        }
    }
    return self;
}

@end
