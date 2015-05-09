//
//  WEProductImgModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductImgModel.h"

@implementation WEProductImgModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.imgurl =[NSString stringWithFormat:@"%@%@",kWEImgUrl,[self stringFromValue:[dict objectForKey:@"imgurl"]]];;
    }
    return self;
}
@end
