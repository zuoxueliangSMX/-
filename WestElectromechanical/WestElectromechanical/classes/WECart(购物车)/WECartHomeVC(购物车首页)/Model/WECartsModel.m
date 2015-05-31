//
//  WECartsModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/12.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECartsModel.h"
#import "MyCartM.h"

@implementation WECartsModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.message =[self stringFromValue:[dict objectForKey:@"message"]];
        self.page =[self stringFromValue:[dict objectForKey:@"page"]];
        self.pagej =[self stringFromValue:[dict objectForKey:@"pagej"]];
        self.products =[NSMutableArray arrayWithCapacity:0];
        NSInteger count =0;
        for (NSDictionary *product in [dict objectForKey:@"products"]) {
            MyCartM *productModel =[[MyCartM alloc]initWithDict:product];
            [self.products addObject:productModel];
            
            count +=[productModel.p_num integerValue];
        }
        if (![[NSUserDefaults standardUserDefaults] objectForKey:kProductCount]) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",count] forKey:kProductCount];
        }else  [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",count] forKey:kProductCount];
       
    }
    return self;
}
@end
