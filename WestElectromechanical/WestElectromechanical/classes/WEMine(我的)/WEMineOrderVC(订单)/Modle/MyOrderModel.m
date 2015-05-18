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
    //给model的属性付值
    
    if (self = [super init]) {
        self.message =[self stringFromValue:[dict objectForKey:@"message"]];
        self.page =[self stringFromValue:[dict objectForKey:@"page"]];
        self.pagej =[self stringFromValue:[dict objectForKey:@"pagej"]];
        self.orders =[NSMutableArray arrayWithCapacity:0];
        //通过看传过来的json的结构 我们知道传过来的 下个属性是个数组   所以我们建立个数组。然后我们给这个数组属性付值做这件事情 ，当然是伟大的for循环了
        for (NSDictionary *order in [dict objectForKey:@"orders"]) {
            //
            OrderM *om =[[OrderM alloc]initWithDict:order];
            WEMyOrderFrame *orderFrame = [[WEMyOrderFrame alloc]init];
            orderFrame.orderModel = om;
            
            //本来我们  加的  是这种OrderM 的对象   但是 它又把这种 对象付给了orderfram的的order＊的属性
            [self.orders addObject:orderFrame];
        }
    }
    return self;
}

@end
