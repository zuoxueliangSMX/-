//
//  WEProductsModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/9.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductsModel.h"
#import "WEProductSingleModel.h"
@implementation WEProductsModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.message =[self stringFromValue:[dict objectForKey:@"message"]];
        self.page =[self stringFromValue:[dict objectForKey:@"page"]];
        self.pagej =[self stringFromValue:[dict objectForKey:@"pagej"]];
        self.products =[NSMutableArray array];
        for (NSDictionary *product in [dict objectForKey:@"products"]) {
            WEProductSingleModel *productModel =[[WEProductSingleModel alloc]initWithDict:product];
            [self.products addObject:productModel];
        }
    }
    return self;
}
@end
