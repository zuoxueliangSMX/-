//
//  ProductsM.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/17.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "ProductsM.h"
#import "NSString+Base64.h"
@implementation ProductsM
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.p_brand =[self stringFromValue:[dict objectForKey:@"p_brand"]];
        self.pid=[self stringFromValue:[dict objectForKey:@"pid"]];
        self.p_imgurl= [NSString stringWithFormat:@"%@%@",kWEProductImgUrl,[self stringFromValue:[dict objectForKey:@"p_imgurl"]]];
        self.p_order_num=[self stringFromValue:[dict objectForKey:@"p_order_num"]];
        self.p_price=[self stringFromValue:[dict objectForKey:@"p_price"]];
        self.p_version=[self stringFromValue:[dict objectForKey:@"p_version"]];
        self.p_name=[[self stringFromValue:[dict objectForKey:@"p_name"]] base64DecodedString];
        self.p_num=[self stringFromValue:[dict objectForKey:@"p_num"]];
//        self.isDeleteNoOrYes = NO;
//        self.isChoose = NO;
    }
    return self;
}

@end
